import psycopg2
import psycopg2.extras


def get_cursor():
    db = psycopg2.connect("dbname='easylist' user='backend' " +
        "host='127.0.0.1' password='amberwhale30'")
    db.autocommit = True
    return db.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

 
def get_row(guid):
    cur = get_cursor()
    cur.execute("select * from get_row(%s)", (guid))
    return cur.fetchall()[0]


def put_row(row):
    cur = get_cursor()
    #print(f"saving row {row}")
    return cur.execute("select put_row(%s, %s, %s, %s, %s)", (
        row["guid"], 
        row["bearer"], 
        row.get("private_key"),
        row.get("installation_token"),
        row.get("session_token")
    ))
