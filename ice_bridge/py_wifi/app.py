import os
import subprocess
import cgi
import json
import SocketServer
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
from flask import Flask, request
from flask_restful import Resource, Api
from json import dumps
# from flask.ext.jsonify import jsonify

app = Flask(__name__)
api = Api(app)


class Employees(Resource):
    def get(self):
        return {"test": "hello"}


class Tracks(Resource):
    def get(self):
        return {"testing": "why"}


class Employees_Name(Resource):
    def get(self, employee_id):
        return {"testing": "why"}


api.add_resource(Employees, '/employees')  # Route_1
api.add_resource(Tracks, '/tracks')  # Route_2


if __name__ == '__main__':
    app.run(port='5002')


# from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
# import SocketServer
# import json
# import cgi
# import subprocess
# import os

# class Server(BaseHTTPRequestHandler):

#     def validate_request(self, path):
#         if (path in self.valid_paths):
#             return True
#         else:
#             return False

#     def _set_headers(self):
#         self.send_response(200)
#         self.send_header('Content-type', 'application/json')
#         self.end_headers()
#         self.send_response(404)

#     def do_HEAD(self):
#         self._set_headers()

#     # GET handler
#     def do_GET(self):
#         if(self.path == '/info'):
#             self._set_headers()
# 	    os.system('sh ./t.sh')
#             self.wfile.write(json.dumps({'hello': 'world', 'received': 'ok'}))
# 	    self.end_headers()
# 	    return
#         else:
#             self.send_response(404)
#             self.end_headers()
#             return

#     # POST handler
#     def do_POST(self):
#         if(self.path == '/setup'):
#             ctype, pdict = cgi.parse_header(
#                 self.headers.getheader('content-type'))

#             # refuse to receive non-json content
#             if ctype != 'application/json':
#                 self.send_response(400)
#                 self.end_headers()
#                 return

#             # read the message and convert it into a python dictionary
#             length = int(self.headers.getheader('content-length'))
#             message = json.loads(self.rfile.read(length))

#             # add a property to the object, just to mess with data
#             message['received'] = 'ok'

#             # send the message back
#             self._set_headers()
#             self.wfile.write(json.dumps(message))
#         else:
#             self.send_response(404)
#             self.end_headers()
#             return


# def run(server_class=HTTPServer, handler_class=Server, port=8008):
#     server_address = ('', port)
#     httpd = server_class(server_address, handler_class)

#     print 'Starting httpd on port %d...' % port
#     try:
#         httpd.serve_forever()
#     except KeyboardInterrupt:
#         print 'closing server...'
#         httpd.server_close()


# if __name__ == "__main__":
#     from sys import argv

#     if len(argv) == 2:
#         run(port=int(argv[1]))
#     else:
#         run()


# #!/usr/bin/env python

# '''
# Simple and functional REST server for Python (2.7) using no dependencies beyond the Python standard library.
# Features:
# * Map URI patterns using regular expressions
# * Map any/all the HTTP VERBS (GET, PUT, DELETE, POST)
# * All responses and payloads are converted to/from JSON for you
# * Easily serve static files: a URI can be mapped to a file, in which case just GET is supported
# * You decide the media type (text/html, application/json, etc.)
# * Correct HTTP response codes and basic error messages
# * Simple REST client included! use the rest_call_json() method
# As an example, let's support a simple key/value store. To test from the command line using curl:
# curl "http://localhost:8080/records"
# curl -X PUT -d '{"name": "Tal"}' "http://localhost:8080/record/1"
# curl -X PUT -d '{"name": "Shiri"}' "http://localhost:8080/record/2"
# curl "http://localhost:8080/records"
# curl -X DELETE "http://localhost:8080/record/2"
# curl "http://localhost:8080/records"
# Create the file web/index.html if you'd like to test serving static files. It will be served from the root URI.
# @author: Tal Liron (tliron @ github.com)
# '''

# import sys
# import os
# import re
# import shutil
# import json
# import urllib
# import urllib2
# import BaseHTTPServer

# # Fix issues with decoding HTTP responses
# reload(sys)
# sys.setdefaultencoding('utf8')

# here = os.path.dirname(os.path.realpath(__file__))

# records = {}


# def get_records(handler):
#     return records


# def get_record(handler):
#     key = urllib.unquote(handler.path[8:])
#     return records[key] if key in records else None


# def set_record(handler):
#     key = urllib.unquote(handler.path[8:])
#     payload = handler.get_payload()
#     records[key] = payload
#     return records[key]


# def delete_record(handler):
#     key = urllib.unquote(handler.path[8:])
#     del records[key]
#     return True  # anything except None shows success


# def rest_call_json(url, payload=None, with_payload_method='PUT'):
#     'REST call with JSON decoding of the response and JSON payloads'
#     if payload:
#         if not isinstance(payload, basestring):
#             payload = json.dumps(payload)
#         # PUT or POST
#         response = urllib2.urlopen(MethodRequest(
#             url, payload, {'Content-Type': 'application/json'}, method=with_payload_method))
#     else:
#         # GET
#         response = urllib2.urlopen(url)
#     response = response.read().decode()
#     return json.loads(response)


# class MethodRequest(urllib2.Request):
#     def __init__(self, *args, **kwargs):
#         if 'method' in kwargs:
#             self._method = kwargs['method']
#             del kwargs['method']
#         else:
#             self._method = None
#         return urllib2.Request.__init__(self, *args, **kwargs)

#     def get_method(self, *args, **kwargs):
#         return self._method if self._method is not None else urllib2.Request.get_method(self, *args, **kwargs)


# class RESTRequestHandler(BaseHTTPServer.BaseHTTPRequestHandler):
#     def __init__(self, *args, **kwargs):
#         self.routes = {
#             r'^/$': {'file': 'web/index.html', 'media_type': 'text/html'},
#             r'^/records$': {'GET': get_records, 'media_type': 'application/json'},
#             r'^/record/': {'GET': get_record, 'PUT': set_record, 'DELETE': delete_record, 'media_type': 'application/json'}}

#         return BaseHTTPServer.BaseHTTPRequestHandler.__init__(self, *args, **kwargs)

#     def do_HEAD(self):
#         self.handle_method('HEAD')

#     def do_GET(self):
#         self.handle_method('GET')

#     def do_POST(self):
#         self.handle_method('POST')

#     def do_PUT(self):
#         self.handle_method('PUT')

#     def do_DELETE(self):
#         self.handle_method('DELETE')

#     def get_payload(self):
#         payload_len = int(self.headers.getheader('content-length', 0))
#         payload = self.rfile.read(payload_len)
#         payload = json.loads(payload)
#         return payload

#     def handle_method(self, method):
#         route = self.get_route()
#         if route is None:
#             self.send_response(404)
#             self.end_headers()
#             self.wfile.write('Route not found\n')
#         else:
#             if method == 'HEAD':
#                 self.send_response(200)
#                 if 'media_type' in route:
#                     self.send_header('Content-type', route['media_type'])
#                 self.end_headers()
#             else:
#                 if 'file' in route:
#                     if method == 'GET':
#                         try:
#                             f = open(os.path.join(here, route['file']))
#                             try:
#                                 self.send_response(200)
#                                 if 'media_type' in route:
#                                     self.send_header(
#                                         'Content-type', route['media_type'])
#                                 self.end_headers()
#                                 shutil.copyfileobj(f, self.wfile)
#                             finally:
#                                 f.close()
#                         except:
#                             self.send_response(404)
#                             self.end_headers()
#                             self.wfile.write('File not found\n')
#                     else:
#                         self.send_response(405)
#                         self.end_headers()
#                         self.wfile.write('Only GET is supported\n')
#                 else:
#                     if method in route:
#                         content = route[method](self)
#                         if content is not None:
#                             self.send_response(200)
#                             if 'media_type' in route:
#                                 self.send_header(
#                                     'Content-type', route['media_type'])
#                             self.end_headers()
#                             if method != 'DELETE':
#                                 self.wfile.write(json.dumps(content))
#                         else:
#                             self.send_response(404)
#                             self.end_headers()
#                             self.wfile.write('Not found\n')
#                     else:
#                         self.send_response(405)
#                         self.end_headers()
#                         self.wfile.write(method + ' is not supported\n')

#     def get_route(self):
#         for path, route in self.routes.iteritems():
#             if re.match(path, self.path):
#                 return route
#         return None


# def rest_server(port):
#     'Starts the REST server'
#     http_server = BaseHTTPServer.HTTPServer(('', port), RESTRequestHandler)
#     print 'Starting HTTP server at port %d' % port
#     try:
#         http_server.serve_forever()
#     except KeyboardInterrupt:
#         pass
#     print 'Stopping HTTP server'
#     http_server.server_close()


# def main(argv):
#     rest_server(5800)


# if __name__ == '__main__':
#     main(sys.argv[1:])
