#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
from socketserver import ThreadingMixIn
import threading
import random

class handler(BaseHTTPRequestHandler):

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
        random_number = random.random()
        s.wfile.write(bytes("<html><head>Simple random number web service</title></head>"
        "<body><p>Your are accessing from: "+str(client)+" Forwarded:"+str(forward)+"</p>"
        "<p>Accessed host is: "+str(server)+"</p>"
        "<p> Your random number is: "+str(random_number)+"</p>"
        "</body></html>", 'UTF-8'))
        return

class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
    """Handle requests in a separate thread."""

if __name__ == '__main__':
    server = ThreadedHTTPServer(('', 3001), handler)
    server.serve_forever()
