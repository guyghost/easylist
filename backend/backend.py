import json
import requests
import sys
import uuid
from cgi import parse_qs

import db

def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])
    d = parse_qs(env["QUERY_STRING"])
    code = d["code"]
    response = requests.post("https://api.oauth.bunq.com/v1/token", params={
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": "https://easylist.aule.net/",
        "client_id": "a2f281751f2cbc38891745428c97595763a2149250b877fc85496547e0a7d88e",
        "client_secret": "11faa3f911144da2905bcea321e10c55a606357a164497d727154f3afeb6750b"
    }).json()
    if "error" in response:
        return [json.dumps(response).encode()]
    guid = str(uuid.uuid4())
    bearer = response["access_token"]
    db.put_row({"guid": guid, "bearer": bearer})
    return [json.dumps({"guid": guid}).encode()]
