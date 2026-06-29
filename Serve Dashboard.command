#!/usr/bin/env python3
"""Double-click to launch the sisko dashboard. No terminal needed.

This script starts a local server in the background and opens your browser.
Close the browser to stop. The Terminal window will close automatically.
"""

import os
import sys
import subprocess
import webbrowser
import time
from http.server import HTTPServer, SimpleHTTPRequestHandler

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SISKO_ROOT = os.path.dirname(SCRIPT_DIR)
PORT = 8080

os.chdir(SISKO_ROOT)

# Check if already running
import socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    sock.bind(('localhost', PORT))
    sock.close()
except OSError:
    webbrowser.open(f'http://localhost:{PORT}')
    print(f'Dashboard already running at http://localhost:{PORT}')
    time.sleep(4)
    sys.exit(0)

server = HTTPServer(('localhost', PORT), SimpleHTTPRequestHandler)

# Launch browser in background
subprocess.Popen(['open', f'http://localhost:{PORT}'])

print(f'Dashboard: http://localhost:{PORT}  (close this window to stop)')
sys.stdout.flush()

try:
    server.serve_forever()
except KeyboardInterrupt:
    pass
