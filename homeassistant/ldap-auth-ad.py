#!/usr/bin/env python
# ldap-auth-ad.py - authenticate Home Assistant against AD via LDAP
# Based on Rechner Fox's ldap-auth.py
# Original found at https://gist.github.com/rechner/57c123d243b8adb83ccb1dc94c80847f

import os
import sys
from ldap3 import Server, Connection, ALL
from ldap3.utils.conv import escape_bytes, escape_filter_chars

# Quick and dirty print to stderr
def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

# XXX: Update these with settings apropriate to your environment:
# (mine below are based on Active Directory and a security group)
SERVER = duoauthproxy.duoauthproxy.svc.cluster.local:389

# We need to search by SAM/UPN to find the DN, so we use a helper account
# This account should be unprivileged and blocked from interactive logon
HELPERDN = CN=svchomeassistant,OU=people,DC=jlv6,DC=com
HELPERPASS = gJEM67rxfLGQXWpkD4VgqL5uWqJSVHeEiKkB4BrAWaekY6xedFcLk9gvSmT7osnxyTusmpxjAgQ7PaTjsdbfKychJAMkSWTuDAxEWsjHvmb8QwD2f4jHHU4Ucc6NKbGu

TIMEOUT = 30
BASEDN = DC=jlv6,DC=com
FILTER = """
    (&
        (objectClass=person)
        (|
            (sAMAccountName={})
            (userPrincipalName={})
        )
        (memberOf=CN=homeassistant_rw,OU=groups,DC=jlv6,DC=com)
    )"""
ATTRS = ""

## End config section

if 'username' not in os.environ or 'password' not in os.environ:
    eprint("Need username and password environment variables!")
    exit(1)

safe_username = escape_filter_chars(os.environ['username'])
FILTER = FILTER.format(safe_username, safe_username)

server = Server(SERVER, get_info=ALL)
try:
    conn = Connection(server, HELPERDN, password=HELPERPASS, auto_bind=True, raise_exceptions=True)
except Exception as e:
    eprint("initial bind failed: {}".format(e))
    exit(1)

search = conn.search(BASEDN, FILTER, attributes='displayName')
if len(conn.entries) > 0: # search is True on success regardless of result size
    eprint("search success: username {}, result {}".format(os.environ['username'], conn.entries))
    user_dn = conn.entries[0].entry_dn
    user_displayName = conn.entries[0].displayName
else:
    eprint("search for username {} yielded empty result".format(os.environ['username']))
    exit(1)

try:
    conn.rebind(user=user_dn, password=os.environ['password'])
except Exception as e:
    eprint("bind as {} failed: {}".format(os.environ['username'], e))
    exit(1)

print("name = {}".format(user_displayName))

eprint("{} authenticated successfully".format(os.environ['username']))
exit(0)
