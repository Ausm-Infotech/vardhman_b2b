import os
from http.server import HTTPServer, BaseHTTPRequestHandler
from ftplib import FTP
import json
import base64
import ssl  # Import the ssl module


#38.137.12.84

# Configuration
FTP_HOST = '172.33.3.45'
FTP_USER = 'vytl'
FTP_PASS = 'Nov#2021'
FTP_DIRECTORY = 'MobileApp'
HTTP_PORT = 8081
USERNAME = 'vytl'
PASSWORD = 'OAIIJDoijf@#'
CERT_FILE = 'cert.pem'  # Path to your certificate file
KEY_FILE = 'key.pem'  # Path to your key file

def get_ftp_files(directory):
    """Fetches the list of files and directories from the FTP server."""
    ftp = FTP(FTP_HOST)
    ftp.login(FTP_USER, FTP_PASS)
    ftp.cwd(directory)
    files = ftp.nlst()
    ftp.quit()
    return files

def download_ftp_file(directory, filename):
    """Downloads a file from the FTP server."""
    ftp = FTP(FTP_HOST)
    ftp.login(FTP_USER, FTP_PASS)
    ftp.cwd(directory)
    with open(filename, 'wb') as f:
        ftp.retrbinary(f'RETR {filename}', f.write)
    ftp.quit()

class BasicAuthHandler(BaseHTTPRequestHandler):
    """HTTP request handler with basic authentication."""

    def do_AUTHHEAD(self):
        self.send_response(401)
        self.send_header('WWW-Authenticate', 'Basic realm="FTP Server"')
        self.end_headers()

    def authenticate(self):
        auth_header = self.headers.get('Authorization')
        if (auth_header is None):
            self.do_AUTHHEAD()
            return False

        auth_type, auth_data = auth_header.split(' ', 1)
        if (auth_type.lower() != 'basic'):
            self.do_AUTHHEAD()
            return False

        decoded = base64.b64decode(auth_data).decode('utf-8')
        username, password = decoded.split(':', 1)
        if (username == USERNAME and password == PASSWORD):
            return True

        self.do_AUTHHEAD()
        return False

    def do_GET(self):
        if not self.authenticate():
            return

        if self.path.startswith('/list'):  # List files and directories
            directory = FTP_DIRECTORY + '/' + self.path[len('/list'):].strip('/').replace('..', '')
            try:
                files = get_ftp_files(directory)
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({"directory": directory, "files": files}).encode('utf-8'))
            except Exception as e:
                self.send_response(500)
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({"error": str(e)}).encode('utf-8'))

        elif self.path.startswith('/download'):  # Download a specific file
            parts = self.path[len('/download'):].strip('/').split('/')
            directory = '/'.join(parts[:-1])
            filename = parts[-1]

            try:
                download_ftp_file(directory, filename)
                self.send_response(200)
                self.send_header('Content-Disposition', f'attachment; filename="{filename}"')
                self.end_headers()
                with open(filename, 'rb') as f:
                    self.wfile.write(f.read())
                os.remove(filename)
            except Exception as e:
                self.send_response(404)
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({"error": str(e)}).encode('utf-8'))

        else:  # Invalid endpoint
            self.send_response(404)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps({"error": "Endpoint not found"}).encode('utf-8'))

if __name__ == '__main__':
    httpd = HTTPServer(('0.0.0.0', HTTP_PORT), BasicAuthHandler)
    # Create an SSL context
    ssl_context = ssl.create_default_context(ssl.Purpose.CLIENT_AUTH)
    ssl_context.load_cert_chain(certfile=CERT_FILE, keyfile=KEY_FILE)
    # Wrap the server socket with SSL
    httpd.socket = ssl_context.wrap_socket(httpd.socket, server_side=True)
    print(f"Starting server on port {HTTP_PORT} with SSL...")
    httpd.serve_forever()