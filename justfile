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

# Serve the web application locally (builds first)
serve:
    @echo "Building project..."
    dart pub get
    @echo "Compiling Dart files to JavaScript..."
    dart compile js web/main.dart -o web/main.dart.js
    dart compile js web/einfaches_system_web.dart -o web/einfaches_system_web.dart.js
    dart compile js web/kompliziertes_system_web.dart -o web/kompliziertes_system_web.dart.js
    dart compile js web/segregation_web.dart -o web/segregation_web.dart.js
    @echo "Stopping any existing server on port 8080..."
    @lsof -ti:8080 2>/dev/null | xargs kill -9 2>/dev/null || true
    @sleep 1
    @echo "Starting web server on http://localhost:8080"
    @echo "Open http://localhost:8080/index.html in your browser"
    @dart run web/server.dart

# Run the project (alias for serve)
run: serve

# Open the web application in the default browser
open:
    open http://localhost:8080/index.html

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

