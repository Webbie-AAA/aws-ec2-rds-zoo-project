"""
Cookie Clicker Web Application with no external dependencies (which is why we didn't use Flask).

A full-stack cookie clicker game implemented in a single Python file using only 
standard library modules (http.server and socketserver). This application serves 
both the frontend HTML/JavaScript and backend API endpoints.

The application structure mimics a Flask-like pattern with separate route handlers,
making it familiar to Flask developers while using Python's built-in HTTP server.

Routes:
    GET  /          - Serves the main HTML page with the cookie clicker game
    GET  /api/count - Returns the current click count as JSON
    POST /api/click - Increments the click count and returns the new count
"""

import http.server
import socketserver
import socket
from http import HTTPStatus

# Global state for tracking total clicks across all sessions
total_clicks = 0


def render_html_template(click_count: int) -> str:
    """
    Render the main HTML page template with embedded JavaScript.

    This function acts similar to Flask's render_template(), generating the
    complete HTML page with the current click count and interactive JavaScript.
    """
    return f"""
        <!DOCTYPE html>
        <html>
        <head>
            <title>Smile Clicker</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script>
                // Update the click count display on the page
                const updateClickDisplay = count => {{
                    document.getElementById("count").innerText = `${{count}} smiles clicked`;
                }};
                
                // Handle cookie click - POST to API and update display
                const handleCookieClick = async () => {{
                    try {{
                        const response = await fetch('/api/click', {{method: "POST"}});
                        const newCount = await response.json();
                        updateClickDisplay(newCount);
                    }} catch (error) {{
                        console.error('Error clicking cookie:', error);
                    }}
                }};
                
                // Fetch current click count from API and update display
                const refreshClickCount = async () => {{
                    try {{
                        const response = await fetch("/api/count");
                        const count = await response.json();
                        updateClickDisplay(count);
                    }} catch (error) {{
                        console.error('Error fetching click count:', error);
                    }}
                }};
                
                // Poll for updates every second (useful for multi-user scenarios)
                setInterval(refreshClickCount, 1000);
            </script>
        </head>
        <body>
            <h3>Click the smile to pass the time</h3>
            <button onclick="handleCookieClick()" style="font-size: 2em; padding: 10px;">&#x1F601;</button>
            <br><br>
            <span id="count">{click_count} smiles clicked</span>
        </body>
        </html>
    """


class CookieClickerHandler(http.server.SimpleHTTPRequestHandler):
    """
    HTTP request handler for the Cookie Clicker application.

    This class handles all HTTP requests and acts similar to Flask route handlers.
    It inherits from SimpleHTTPRequestHandler to get basic HTTP functionality.
    """

    def do_GET(self) -> None:
        """
        Handle GET requests - similar to Flask's @app.route('/', methods=['GET'])

        Routes:
            / - Main page with the cookie clicker game
            /api/count - JSON API endpoint returning current click count
        """
        global total_clicks  # Access the global click count, if we don't do this, we can't modify it in the global scope

        if self.path == '/':
            # Serve the main HTML page (like Flask's return render_template())
            self._send_html_response(render_html_template(total_clicks))

        elif self.path == '/api/count':
            # API endpoint to get current click count (like Flask's return jsonify())
            self._send_json_response(total_clicks)

        else:
            # Handle 404 for unknown paths
            self.send_error(HTTPStatus.NOT_FOUND, "Page not found")

    def do_POST(self) -> None:
        """
        Handle POST requests - similar to Flask's @app.route('/api/click', methods=['POST'])

        Routes:
            /api/click - Increment click counter and return new count
        """
        global total_clicks  # Access the global click count, if we don't do this, we can't modify it in the global scope

        if self.path == '/api/click':
            # Increment click count and return new value
            total_clicks += 1
            self._send_json_response(total_clicks)

        else:
            # Handle 404 for unknown POST paths
            self.send_error(HTTPStatus.NOT_FOUND, "Endpoint not found")

    def _send_html_response(self, html_content: str) -> None:
        """
        Send an HTML response - helper method similar to Flask's response handling.
        """
        self.send_response(HTTPStatus.OK)
        self.send_header("Content-type", "text/html; charset=utf-8")
        self.end_headers()
        self.wfile.write(html_content.encode('utf-8'))

    def _send_json_response(self, data: dict) -> None:
        """
        Send a JSON response - helper method similar to Flask's jsonify().

        """
        self.send_response(HTTPStatus.OK)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        # Note: In a real Flask app, you'd use jsonify() here
        self.wfile.write(str(data).encode('utf-8'))


def create_app() -> socketserver.TCPServer:
    """
    Application factory function - similar to Flask's create_app() pattern.
    """
    # Create server on port 80 with our custom handler
    server = socketserver.TCPServer(('', 5000), CookieClickerHandler)
    # Allow the address to be reused immediately after shutdown - this prevents "Address already in use" errors
    server.allow_reuse_address = True
    # Set socket options for better reuse behavior on AWS/Linux
    server.socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    return server


def run_app():
    """
    Run the application - similar to Flask's app.run().

    This starts the server and handles requests indefinitely.
    """
    print('Starting Smiling Clicker application...')
    print("Server is running at http://127.0.0.1:5000")
    print("Press Ctrl+C to stop the server")

    try:
        server = create_app()
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nShutting down server...")
        server.shutdown()
        server.server_close()


if __name__ == '__main__':
    # Entry point - similar to Flask's if __name__ == '__main__': app.run()
    run_app()
