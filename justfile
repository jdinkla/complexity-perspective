# Justfile for complexity-perspective Dart project

# Default recipe - show available commands
default:
    @just --list

# Run all tests
test:
    dart test

# Get dependencies
deps:
    dart pub get

# Build the project (compile Dart web files to JavaScript)
build:
    @echo "Building Dart web application..."
    dart pub get
    @echo "Compiling main.dart..."
    dart compile js web/main.dart -o web/main.dart.js
    @echo "Compiling einfaches_system_web.dart..."
    dart compile js web/einfaches_system_web.dart -o web/einfaches_system_web.dart.js
    @echo "Compiling kompliziertes_system_web.dart..."
    dart compile js web/kompliziertes_system_web.dart -o web/kompliziertes_system_web.dart.js
    @echo "Compiling segregation_web.dart..."
    dart compile js web/segregation_web.dart -o web/segregation_web.dart.js
    @echo "Build complete!"

# Serve the web application locally
serve:
    @echo "Starting web server on http://localhost:8080"
    @echo "Open http://localhost:8080/index.html in your browser"
    @(cd web && python3 -m http.server 8080 2>/dev/null) || (cd web && python -m SimpleHTTPServer 8080 2>/dev/null) || (echo "Python not found. Please install Python or use a different HTTP server." && exit 1)

# Run the project (alias for serve)
run: serve

# Clean build artifacts
clean:
    rm -rf .dart_tool
    rm -rf build
    find web -name "*.dart.js" -type f -delete
    find web -name "*.js.map" -type f -delete
    @echo "Cleaned build artifacts"

# Format code
format:
    dart format .

# Analyze code
analyze:
    dart analyze

# Run tests with coverage
test-coverage:
    dart test --coverage=coverage
    @echo "Coverage report generated in coverage/"

# Run tests in watch mode
test-watch:
    dart test --watch

