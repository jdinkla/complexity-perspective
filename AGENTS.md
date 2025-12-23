# AGENTS.md

This document provides guidelines and context for AI agents working on this codebase.

## Project Overview

This is a Dart web application containing simulations for the book "Die ‚komplexe‘ Perspektive - Einführung in die digitale Wirtschaft" (The Complex Perspective - Introduction to Digital Economy). The project demonstrates various complexity models including:

- Simple system with three planets
- Complex system with three planets and gravity
- Segregation model (Schelling model)

## Project Structure

```
complexity-perspective/
├── web/              # Web application code and HTML files
│   ├── *.dart        # Dart source files
│   └── *.html        # HTML entry points
├── test/             # Unit tests
├── db/               # Database scripts (Neo4j, CouchDB)
├── pubspec.yaml      # Dart project configuration
├── justfile          # Task runner commands
└── README.md         # User-facing documentation
```

## Key Technologies

- **Dart SDK**: 3.0+ (null safety enabled)
- **Test Framework**: `test` package (^1.24.0)
- **Target**: Web browser (compiles to JavaScript)

## Code Conventions

### Null Safety

This codebase has been migrated to Dart 3.x with null safety enabled. Important patterns:

- Use nullable types (`T?`) when values can be null
- Use `late` keyword for fields initialized in constructors
- Use null-aware operators (`?.`, `??`) appropriately
- Arrays use `List<T?>` to allow null elements

### Operator Overrides

When overriding `==`, always accept `Object?`:

```dart
@override
bool operator ==(Object? other) => other is MyClass && field == other.field;
```

### List Initialization

Use `List.filled()` or `List.generate()` instead of deprecated `new List<T>(length)`:

```dart
// ✅ Correct
elements = List<T?>.filled(m*n, null);

// ❌ Deprecated
elements = new List<T>(m*n);
```

### Constructor Syntax

Prefer modern constructor syntax (no `new` keyword):

```dart
// ✅ Correct
var array = Array<int>(2, 2);

// ❌ Deprecated
var array = new Array<int>(2, 2);
```

## Core Classes

### Data Structures (`web/`)

- **`Coordinate`**: 2D coordinate (x, y) with `num` type
- **`Vector`**: 2D vector with x, y components
- **`Coordinates`**: Helper for 2D coordinate system operations (index conversion, wrapping)
- **`Array<T>`**: Generic 2D array with nullable elements (`List<T?>`)
- **`Cells<T>`**: Extends `Array<T>` with neighbor finding and empty cell management
- **`Distribution<T>`**: Probability distribution for random selection

### Simulation Models

- **`Circle`**: Represents a celestial body with color, mass, position, velocity
- **`Segregation`**: Schelling segregation model implementation
- **`Agent`**: Agent in segregation model with color and movement logic
- **`Statistics`**: Tracks moves and changes in segregation simulation

### Entry Points

- **`main.dart`**: Main entry point (minimal)
- **`einfaches_system_web.dart`**: Simple system web entry
- **`kompliziertes_system_web.dart`**: Complex system web entry
- **`segregation_web.dart`**: Segregation model web entry

## Testing

### Test Structure

- Tests are in `test/` directory
- Each test file corresponds to a source file: `*_test.dart`
- Use `package:test/test.dart` for testing framework

### Running Tests

```bash
# Run all tests
just test
# or
dart test

# Run tests in watch mode
just test-watch

# Run with coverage
just test-coverage
```

### Test Conventions

- Use `late` for test variables initialized in `setUp()`
- Test files mirror source file structure
- Group related tests with `group()`
- Use descriptive test names

## Common Tasks

### Adding a New Feature

1. Create/modify source files in `web/`
2. Write tests in `test/`
3. Run `just test` to verify
4. Update HTML files if needed for web entry points

### Fixing Null Safety Issues

When encountering null safety errors:

1. Identify if the value can actually be null
2. Use `T?` for nullable types
3. Use `late` for fields initialized in constructors
4. Add null checks or null-aware operators as needed

### Building for Production

```bash
# Compile all Dart files to JavaScript
just build

# Clean build artifacts
just clean
```

### Running Locally

```bash
# Start development server
just serve
# or
just run

# Then open http://localhost:8080/index.html
```

## Important Notes

### Type Conversions

- `Coordinate.x` and `Coordinate.y` are `num` type
- When passing to functions expecting `int`, use `.toInt()`
- Example: `index(c.x.toInt(), c.y.toInt())`

### Deprecated Patterns

The following patterns were used in Dart 1.x but are now deprecated:

- ❌ `new List<T>(length)` → ✅ `List<T>.filled(length, value)`
- ❌ `new ClassName()` → ✅ `ClassName()`
- ❌ `operator ==(SpecificType)` → ✅ `operator ==(Object?)`
- ❌ Non-nullable types for potentially null values → ✅ Use `T?`

### Web Compatibility

- HTML files reference Dart files directly (legacy pattern)
- For production, compile to JavaScript with `dart compile js`
- The project uses `dart:html` for browser APIs
- Old `browser` package has been removed (use `dart:html` directly)

## File Naming

- Source files: `snake_case.dart`
- Test files: `*_test.dart`
- HTML files: `snake_case.html`
- Class files: `PascalCase.dart` (e.g., `Distribution.dart`)

## Dependencies

Current dependencies are minimal:
- No runtime dependencies
- `test` package for testing (dev dependency)

## Migration History

This codebase was migrated from Dart 1.x to Dart 3.x, which involved:

1. Enabling null safety
2. Updating operator overrides
3. Replacing deprecated List constructors
4. Removing `new` keyword
5. Fixing type conversions (`num` to `int`)
6. Updating test framework

## When Making Changes

1. **Always run tests**: `just test` before committing
2. **Check formatting**: `just format` to ensure consistent style
3. **Analyze code**: `just analyze` to catch potential issues
4. **Update tests**: Add tests for new features
5. **Maintain null safety**: Ensure all changes respect null safety rules

## Quick Reference

```bash
# Development workflow
just deps          # Get dependencies
just test          # Run tests
just format        # Format code
just analyze       # Analyze code
just build         # Build for production
just serve         # Run locally
just clean         # Clean artifacts
```

## Questions to Consider

When working on this codebase:

1. **Can this value be null?** → Use `T?` if yes
2. **Is this initialized in constructor?** → Use `late` if yes
3. **Does this override `==`?** → Must accept `Object?`
4. **Is this a List initialization?** → Use `List.filled()` or `List.generate()`
5. **Does this need a test?** → Yes, add one in `test/`

