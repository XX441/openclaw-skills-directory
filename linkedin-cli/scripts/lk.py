import os
import sys
import argparse
import json
import requests
import urllib.parse
from linkedin_api import Linkedin
from requests.cookies import RequestsCookieJar

# Styling
BOLD = "\033[1m"
RESET = "\033[0m"
BLUE = "\033[94m"
GREEN = "\033[92m"
RED = "\033[91m"

# OAuth config (for posting)
LINKEDIN_OAUTH_TOKEN = os.environ.get("LINKEDIN_OAUTH_TOKEN", "")
AUTHOR_URN = "urn:li:person:phVnOz8FnR"  # Leo's URN

def get_api():
    li_at = os.environ.get("LINKEDIN_LI_AT")
    jsessionid = os.environ.get("LINKEDIN_JSESSIONID")
    if not li_at or not jsessionid:
        print("Error: LINKEDIN_LI_AT and LINKEDIN_JSESSIONID environment variables not set.")
        sys.exit(1)
    
    jar = RequestsCookieJar()
    jar.set("li_at", li_at, domain=".www.linkedin.com")
    jar.set("JSESSIONID", jsessionid, domain=".www.linkedin.com")
    
    return Linkedin("", "", cookies=jar)

def whoami(api):
    profile = api.get_user_profile()
    name = f"{profile.get('firstName', '')} {profile.get('lastName', '')}".strip()
    headline = profile.get('headline', profile.get('miniProfile', {}).get('occupation', 'No headline'))
    location = profile.get('locationName', 'Unknown')
    print(f"{BOLD}{name}{RESET}")
    print(f"{BLUE}{headline}{RESET}")
    print(f"📍 {location}")

def search(api, query):
    results = api.search_people(keywords=query, limit=10)
    print(f"Search results for '{BOLD}{query}{RESET}':")
    for res in results:
        name = res.get('name', 'Unknown')
        job = res.get('jobtitle', 'No headline')
        urn = res.get('urn_id', 'No URN')
        print(f"- {BOLD}{name}{RESET} ({urn})")
        print(f"  {job}")

def view_profile(api, public_id):
    profile = api.get_profile(public_id)
    name = f"{profile.get('firstName', '')} {profile.get('lastName', '')}"
    headline = profile.get('headline', 'No headline')
    summary = profile.get('summary', 'No summary provided.')
    
    print(f"{BOLD}{name}{RESET}")
    print(f"{BLUE}{headline}{RESET}")
    print("-" * 20)
    print(summary)
    
    print(f"\n{BOLD}Experience:{RESET}")
    for exp in profile.get('experience', [])[:3]:
        company = exp.get('companyName', 'Unknown')
        title = exp.get('title', 'Unknown')
        print(f"• {BOLD}{title}{RESET} at {company}")

def check_messages(api):
    conversations = api.get_conversations()
    print(f"{BOLD}Recent Conversations:{RESET}")
    for conv in conversations.get('elements', [])[:5]:
        participants = ", ".join([p.get('firstName', 'Unknown') for p in conv.get('participants', [])])
        events = conv.get('events', [{}])
        snippet = "No preview"
        if events:
             content = events[0].get('eventContent', {})
             msg_event = content.get('com.linkedin.voyager.messaging.event.MessageEvent', {})
             snippet = msg_event.get('body', 'No preview')
        
        print(f"• {BOLD}{participants}{RESET}")
        print(f"  {snippet[:100]}...")

def feed(api, count=10):
    posts = api.get_feed_posts(limit=count)
    print(f"{BOLD}LinkedIn Feed (Top {count}):{RESET}")
    for post in posts:
        author = post.get('author_name', 'Unknown')
        time = post.get('old', 'Recently').strip()
        content = post.get('content', 'No content').replace('\n', ' ')
        print(f"• {BOLD}{author}{RESET} ({time}): {content[:200]}...")

def post(text):
    """Post a text update to LinkedIn using OAuth API."""
    if not LINKEDIN_OAUTH_TOKEN:
        print(f"{RED}Error: LINKEDIN_OAUTH_TOKEN environment variable not set.{RESET}")
        print("Set it with: export LINKEDIN_OAUTH_TOKEN='your_token'")
        sys.exit(1)
    
    headers = {
        'Authorization': f'Bearer {LINKEDIN_OAUTH_TOKEN}',
        'Content-Type': 'application/json',
        'X-Restli-Protocol-Version': '2.0.0',
        'LinkedIn-Version': '202502'
    }
    
    post_data = {
        'author': AUTHOR_URN,
        'lifecycleState': 'PUBLISHED',
        'specificContent': {
            'com.linkedin.ugc.ShareContent': {
                'shareCommentary': {
                    'text': text
                },
                'shareMediaCategory': 'NONE'
            }
        },
        'visibility': {
            'com.linkedin.ugc.MemberNetworkVisibility': 'PUBLIC'
        }
    }
    
    r = requests.post('https://api.linkedin.com/v2/ugcPosts', headers=headers, json=post_data)
    
    if r.status_code in [200, 201]:
        data = r.json()
        post_id = data.get('id', 'unknown')
        print(f"{GREEN}✅ Posted successfully!{RESET}")
        print(f"   Post URN: {post_id}")
        return post_id
    else:
        print(f"{RED}❌ Failed to post (HTTP {r.status_code}){RESET}")
        print(f"   {r.text[:500]}")
        return None

def delete_post(post_urn):
    """Delete a post by URN."""
    if not LINKEDIN_OAUTH_TOKEN:
        print(f"{RED}Error: LINKEDIN_OAUTH_TOKEN not set.{RESET}")
        sys.exit(1)
    
    headers = {
        'Authorization': f'Bearer {LINKEDIN_OAUTH_TOKEN}',
        'X-Restli-Protocol-Version': '2.0.0',
        'LinkedIn-Version': '202502'
    }
    
    encoded_urn = urllib.parse.quote(post_urn, safe='')
    delete_url = f'https://api.linkedin.com/v2/ugcPosts/{encoded_urn}'
    r = requests.delete(delete_url, headers=headers)
    
    if r.status_code == 204:
        print(f"{GREEN}✅ Deleted: {post_urn}{RESET}")
    else:
        print(f"{RED}❌ Delete failed (HTTP {r.status_code}): {r.text[:300]}{RESET}")

def verify_oauth():
    """Verify OAuth token is working."""
    if not LINKEDIN_OAUTH_TOKEN:
        print(f"{RED}❌ LINKEDIN_OAUTH_TOKEN not set.{RESET}")
        return False
    
    headers = {
        'Authorization': f'Bearer {LINKEDIN_OAUTH_TOKEN}',
        'LinkedIn-Version': '202502'
    }
    
    r = requests.get('https://api.linkedin.com/v2/userinfo', headers=headers)
    if r.status_code == 200:
        data = r.json()
        print(f"{GREEN}✅ OAuth token valid{RESET}")
        print(f"   {BOLD}{data.get('name', 'Unknown')}{RESET} — {data.get('email', '')}")
        return True
    elif r.status_code == 401:
        print(f"{RED}❌ OAuth token invalid or expired.{RESET}")
    else:
        print(f"{RED}❌ OAuth check failed (HTTP {r.status_code}): {r.text[:200]}{RESET}")
    return False

def main():
    parser = argparse.ArgumentParser(description="lk - LinkedIn CLI")
    subparsers = parser.add_subparsers(dest="command")

    subparsers.add_parser("whoami", help="Display current user profile")
    
    search_parser = subparsers.add_parser("search", help="Search for people")
    search_parser.add_argument("query", help="Search keywords")
    
    profile_parser = subparsers.add_parser("profile", help="View profile details")
    profile_parser.add_argument("public_id", help="Public ID or URN")
    
    subparsers.add_parser("messages", help="Check recent messages")
    
    feed_parser = subparsers.add_parser("feed", help="Summarize your timeline")
    feed_parser.add_argument("-n", "--count", type=int, default=10, help="Number of posts to fetch")
    
    subparsers.add_parser("check", help="Quick status check")
    
    post_parser = subparsers.add_parser("post", help="Post a text update to LinkedIn")
    post_parser.add_argument("text", help="Post content")
    
    delete_parser = subparsers.add_parser("delete", help="Delete a post by URN")
    delete_parser.add_argument("urn", help="Post URN (e.g. urn:li:share:7462008860434862080)")
    
    subparsers.add_parser("verify", help="Verify OAuth token is working")

    args = parser.parse_args()

    if not args.command:
        parser.print_help()
        return

    # Handle OAuth-based commands (don't need cookie API)
    if args.command == "post":
        post(args.text)
        return
    elif args.command == "delete":
        delete_post(args.urn)
        return
    elif args.command == "verify":
        verify_oauth()
        return

    # Cookie-based commands
    api = get_api()

    try:
        if args.command == "whoami":
            whoami(api)
        elif args.command == "search":
            search(api, args.query)
        elif args.command == "profile":
            view_profile(api, args.public_id)
        elif args.command == "messages":
            check_messages(api)
        elif args.command == "feed":
            feed(api, args.count)
        elif args.command == "check":
            whoami(api)
            print("-" * 10)
            check_messages(api)
    except Exception as e:
        print(f"{BOLD}LinkedIn Error:{RESET} {e}")

if __name__ == "__main__":
    main()
