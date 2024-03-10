# shopper

This project is a starting point for a Flutter application with clean architecture.

## Architecture

### Sequence
User input -> View -> Viewmodel -> Service -> Repository -> Data Provider -> SQLite / Server

### Data layer
- models
- file
- preferences (shared_preferences)
- data sources (database, network)
- repositories

### Domain layer
- services (business logic)

### Presentation layer
- viewmodels
- views
