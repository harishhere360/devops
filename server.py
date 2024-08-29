from http.server import HTTPServer, SimpleHTTPRequestHandler
import ssl

# Define the server address and port
server_address = ('', 4443)

# Create an HTTP server instance
httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)

# Wrap the server with SSL
httpd.socket = ssl.wrap_socket(
    httpd.socket,
    keyfile="/home/webuser/certs/server.key",
    certfile="/home/webuser/certs/server.crt",
    server_side=True
)

print("Serving on https://localhost:4443")
httpd.serve_forever()
from http.server import HTTPServer, SimpleHTTPRequestHandler
import ssl

# Define the server address and port
server_address = ('', 4443)

# Create an HTTP server instance
httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)

# Wrap the server with SSL
httpd.socket = ssl.wrap_socket(
    httpd.socket,
    keyfile="/home/webuser/certs/server.key",
    certfile="/home/webuser/certs/server.crt",
    server_side=True
)

print("Serving on https://localhost:4443")
httpd.serve_forever()
