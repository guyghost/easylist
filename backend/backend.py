import json
import requests
import sys
import uuid
from cgi import parse_qs

import db
import secret

def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])
    d = parse_qs(env["QUERY_STRING"])
    code = d["code"]
    response = requests.post("https://api.oauth.bunq.com/v1/token", params={
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": "https://easylist.aule.net/",
        "client_id": "88ad9f89f0081f7d17a9552a7ff8403b48882a521dcd5a7d7229aab16e721386",
        "client_secret": secret.get_client_secret()
    }).json()
    if "error" in response:
        return [json.dumps(response).encode()]
    guid = str(uuid.uuid4())
    bearer = response["access_token"]
    db.put_row({"guid": guid, "bearer": bearer})
    return [json.dumps({"guid": guid}).encode()]
