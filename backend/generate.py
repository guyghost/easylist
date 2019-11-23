import argparse
from decimal import Decimal
import json
import sys
from cgi import parse_qs

import bunq
import db


bunq.set_log_level(0)


def process_account(row, user_id, account_id):
    result = ""
    method = ("v1/user/{0}/monetary-account/{1}/payment?count=24"
              .format(user_id, account_id))
    payments = bunq.get(row, method)
    for v in [p["Payment"] for p in payments]:
        result += "{0},{1},{2},{3},{4},{5},{6},{7},{8},{9}\n".format(
            v["amount"]["value"],
            v["amount"]["currency"],
            v["created"][:16],
            v["type"],
            v["sub_type"],
            v["description"],
            v["alias"]["iban"],
            v["alias"]["display_name"],
            v["counterparty_alias"]["iban"],
            v["counterparty_alias"]["display_name"]
        )
    return result 


def process_user(row, user_id):
    result = ""
    method = 'v1/user/{0}/monetary-account'.format(user_id)
    for a in bunq.get(row, method):
        for k, v in a.items():
            result += process_account(row, user_id, v["id"])
    return result

def get_transactions(row):
    result = ""
    users = bunq.get(row, 'v1/user')
    for u in users:
        for k, v in u.items():
            #result += f"{k} {v['display_name']} {v['id']}"
            result += process_user(row, v['id'])
    return result


def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/csv')])
    d = parse_qs(env["QUERY_STRING"])
    guid = d["guid"]
    row = db.get_row(guid)
    result = get_transactions(row)
    db.put_row(row)
    return [result.encode()]
