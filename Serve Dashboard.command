#!/usr/bin/python3
"""Double-click to launch the sisko dashboard. No terminal needed."""

import os, sys, subprocess, time, posixpath, urllib.parse
from http.server import HTTPServer, SimpleHTTPRequestHandler

try:
    SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
    SISKO_ROOT = SCRIPT_DIR  # this file lives in sisko root, not bin/
    WORKSPACE_ROOT = os.path.dirname(SISKO_ROOT)
    PORT = 8080

    class Handler(SimpleHTTPRequestHandler):
        extensions_map = {**SimpleHTTPRequestHandler.extensions_map, '.md': 'text/plain; charset=utf-8'}

        def translate_path(self, path):
            p = posixpath.normpath(urllib.parse.unquote(path.split('?')[0].split('#')[0]))
            words = [w for w in p.split('/') if w and w != '..']
            if len(words) >= 2 and words[0] == 'outposts':
                fname = words[-1]
                lp = os.path.join(SISKO_ROOT, 'outposts', fname)
                if os.path.islink(lp):
                    rp = os.path.realpath(lp)
                    if rp.startswith(WORKSPACE_ROOT):
                        return rp
            return super().translate_path(path)

        def log_message(self, format, *args):
            pass

    os.chdir(SISKO_ROOT)

    # Kill anything already on this port
    r = subprocess.run(['lsof', '-ti', f':{PORT}'], capture_output=True, text=True)
    for pid in r.stdout.strip().split('\n'):
        if pid:
            try: os.kill(int(pid), 9)
            except: pass
            time.sleep(0.3)

    server = HTTPServer(('localhost', PORT), Handler)
    subprocess.Popen(['open', f'http://localhost:{PORT}'])
    print(f'\n  sisko dashboard  ->  http://localhost:{PORT}\n')
    print('  Close this window to stop the server.\n')
    sys.stdout.flush()
    server.serve_forever()

except Exception as e:
    print(f'\n  Error: {e}\n', file=sys.stderr)
    input('  Press Enter to close...')
    sys.exit(1)
