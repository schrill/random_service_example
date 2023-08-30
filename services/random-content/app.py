#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
from socketserver import ThreadingMixIn
import threading
import redis
import random_name_generator as rng
from functools import reduce

class handler(BaseHTTPRequestHandler):

  r = redis.Redis(host='redis-master', port=6379, db=0)

  def _set_headers(s):
        s.send_response(200)
        s.send_header('Content-type', 'text/html')
        s.end_headers()

  def do_HEAD(s):
        s._set_headers()

  def do_GET(s):
        s._set_headers()
        forward = s.headers.get("x-forwarded-for")
        server = s.headers.get("host")
        client = s.client_address[0]
        random_names = list()
        for x in range(10):
             random_names.append(rng.generate(descent=rng.Descent.ENGLISH, sex=rng.Sex.FEMALE, limit=1))
        random_names = reduce(lambda a,b:a+b, random_names)
        s.r.setnx("customer", ", ".join(random_names))
        customer = s.r.get("customer")
        s.wfile.write(bytes("<html><head>Simple web server</title></head>"
        "<body><p>Your are accessing from: "+str(client)+" Forwarded:"+str(forward)+"</p>"
        "<p>Accessed host is: "+str(server)+"</p>"
        "<p> Your contact list is : "+str(customer)+"</p>"
        "</body></html>", 'UTF-8'))
        s.r.expire("customer", 60)
        return

class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
    """Handle requests in a separate thread."""

if __name__ == '__main__':
    server = ThreadedHTTPServer(('', 3003), handler)
    server.serve_forever()
