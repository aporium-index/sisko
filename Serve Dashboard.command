#!/usr/bin/env python3
"""Double-click to launch the sisko dashboard. No terminal needed."""

import os
import sys
import subprocess
import webbrowser
import time
import socket
import posixpath
import urllib.parse
from http.server import HTTPServer, SimpleHTTPRequestHandler

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SISKO_ROOT = os.path.dirname(SCRIPT_DIR)
WORKSPACE_ROOT = os.path.dirname(SISKO_ROOT)
PORT = 8080


class WorkspaceHandler(SimpleHTTPRequestHandler):
    """Serve sisko files AND resolve outpost symlinks into workspace."""
    
    def translate_path(self, path):
        path = path.split('?', 1)[0]
        path = path.split('#', 1)[0]
        path = posixpath.normpath(urllib.parse.unquote(path))
        
        # First try within sisko root (for index.html, standards/, etc.)
        words = path.split('/')
        words = [w for w in words if w and w != '..']
        
        # Check if this is a request for an outpost state file
        #   /outposts/<slug>-state.md
        if len(words) >= 2 and words[0] == 'outposts':
            filename = words[-1]
            outpost_path = os.path.join(SISKO_ROOT, 'outposts', filename)
            if os.path.islink(outpost_path):
                real = os.path.realpath(outpost_path)
                if real.startswith(WORKSPACE_ROOT):
                    return real
        
        # Default: serve from sisko root
        return os.path.join(SISKO_ROOT, *words)


os.chdir(SISKO_ROOT)

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    sock.bind(('localhost', PORT))
    sock.close()
except OSError:
    webbrowser.open(f'http://localhost:{PORT}')
    time.sleep(4)
    sys.exit(0)

server = HTTPServer(('localhost', PORT), WorkspaceHandler)
subprocess.Popen(['open', f'http://localhost:{PORT}'])
print(f'Dashboard: http://localhost:{PORT}  (close this window to stop)')
sys.stdout.flush()

try:
    server.serve_forever()
except KeyboardInterrupt:
    pass
