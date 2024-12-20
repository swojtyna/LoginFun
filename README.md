# LoginFun iOS App

A demo application showcasing clean architecture, MVVM+C pattern, and modern iOS development practices.

## Features
- Login screen with basic authentication
- Server list with sorting capabilities
- Persistent authentication state
- Offline data support

## Architecture
The app follows Clean Architecture principles with MVVM+C (Model-View-ViewModel + Coordinator) pattern:

### Key Components:
- **Views**: SwiftUI views with clear separation of concerns
- **ViewModels**: Managing UI state and business logic
- **Coordinators**: Handling navigation flow
- **UseCases**: Encapsulating business rules
- **Repositories**: Managing data access
- **Storage**: Handling local data persistence

### Dependencies
The app uses a custom Dependency Injection container for managing dependencies and mocking in tests.

### Networking
- Custom API client with endpoint-based architecture
- Proper error handling
- Authorization token management

### Storage
The app uses UserDefaults for storage (temporary solution):
- `SecureStorage`: For authentication token (should use Keychain in production)
- `ServersStorage`: For caching server list data (consider using Core Data/Realm in production)

## Testing
- Unit tests with clear arrange/act/assert structure
- Custom test helpers for async/await testing
- Proper mocking of dependencies
- Tests for all key features and edge cases

## Known Limitations
- Uses UserDefaults instead of Keychain for token storage
- Basic error handling could be enhanced
- Missing UI tests
- Could benefit from better offline support
- Network layer could use more robust caching

## Future Improvements
- Implement Keychain storage for sensitive data
- Add better error handling and user feedback
- Implement proper data persistence layer
- Add UI tests
- Enhance offline capabilities

## Requirements
- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## Getting Started
1. Clone the repository
2. Open `loginfun.xcodeproj`
3. Build and run

## Testing
Run tests using CMD+U or through Xcode's Test Navigator.