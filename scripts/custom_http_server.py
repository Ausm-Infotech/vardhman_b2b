import os
import http.server
import socketserver

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):
        print(f"Received POST request: {self.path}")
        self.do_GET()

if __name__ == "__main__":
    PORT = 8000
    # Change the working directory to the build/web folder
    os.chdir("build/web")
    with socketserver.TCPServer(("", PORT), CustomHandler) as httpd:
        print(f"Serving on port {PORT}, root directory: {os.getcwd()}")
        httpd.serve_forever()
