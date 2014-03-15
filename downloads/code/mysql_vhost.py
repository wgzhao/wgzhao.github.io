#!/usr/bin/env python
import sys
import MySQLdb

# load configuration data from the database
db=MySQLdb.connect(host='localhost', db=sys.argv[1], user=sys.argv[2], 
passwd=sys.argv[3])
cur = db.cursor()
cur.execute("SELECT * FROM domains")
rs=cur.fetchall()
db.close()

for domain in rs:
	print "$HTTP["host"] == "%s" {nserver.document-root = "%s"n%sn}" % 
(domain[0], domain[1], domain[2])

