# Flutter Week 5 App 

A Flutter application demonstrating API integration, networking, error handling, and modern UI design principles.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [Dependencies](#dependencies)
- [API Integration](#api-integration)
- [Week 4 Requirements](#week-4-requirements)
- [Technical Implementation](#technical-implementation)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)

## 🎯 Overview

This Flutter application is built as part of the Flutter Developers Internship Program (Cycle 2) - Week 4 assignment. It demonstrates professional implementation of HTTP networking, JSON parsing, error handling, and modern Material Design 3 UI patterns.

The app fetches user data from the JSONPlaceholder API and presents it in a beautiful, user-friendly interface with comprehensive error handling and loading states.

## ✨ Features

### Core Functionality
- ✅ **HTTP API Integration** - Fetch data from RESTful APIs
- ✅ **JSON Parsing** - Convert JSON responses to Dart objects
- ✅ **User List Display** - Shows all users in a scrollable list
- ✅ **User Profile Details** - Detailed view of individual user information
- ✅ **Pull to Refresh** - Refresh data with pull-down gesture
- ✅ **Error Handling** - Comprehensive error management
- ✅ **Loading States** - Visual feedback during data fetching

### UI/UX Features
- 🎨 **Modern Material Design 3** theme
- 🌈 **Color-coded User Avatars** (6 vibrant gradient colors)
- 💫 **Hero Animations** between screens
- 📱 **Responsive Layouts** for different screen sizes
- ✨ **Smooth Transitions** and animations
- 🎯 **Clean Card-based Interface**
- 🔄 **Interactive Refresh Indicators**

### Error Handling
- 🌐 **Network Connectivity Checks**
- ⏱️ **Request Timeout Handling** (10 seconds)
- 🔄 **Retry Functionality**
- 📊 **User-friendly Error Messages**
- 🚫 **Graceful Failure Management**

## 📸 Screenshots

### Home Screen
- Displays list of users fetched from API
- Gradient-colored user avatars
- Pull-to-refresh functionality
- Loading indicators
- Clean card-based design

### User Profile Screen
- Expandable gradient header with user avatar
- Complete user information display
- Contact details (email, phone, website)
- Address information
- Company details
- Posts count activity tracker

## 📂 Project Structure

```
flutter_week4_app/
├── lib/
│   ├── main.dart                      # App entry point & theme configuration
│   ├── models/
│   │   └── user_model.dart           # User data model with JSON parsing
│   ├── services/
│   │   └── api_service.dart          # API service for HTTP requests & error handling
│   └── screens/
│       ├── home_screen.dart          # Users list screen with pull-to-refresh
│       └── user_profile_screen.dart  # User profile details screen
├── android/                           # Android platform files
├── ios/                              # iOS platform files
├── web/                              # Web platform files
├── linux/                            # Linux platform files
├── macos/                            # macOS platform files
├── windows/                          # Windows platform files
├── test/                             # Unit and widget tests
├── firebase.json                     # Firebase configuration
├── pubspec.yaml                      # Project dependencies
└── README.md                         # This file
```

## 🚀 Setup Instructions

### Prerequisites

Before you begin, ensure you have the following installed:
- **Flutter SDK** (3.0.0 or higher)
- **Dart SDK** (3.0.0 or higher)
- **Android Studio** or **VS Code** with Flutter extensions
- An **Android emulator**, **iOS simulator**, or **physical device**

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/Anmol-png/flutter_week4_app.git
   cd flutter_week4_app
   ```

2. **Checkout week5 branch**
   ```bash
   git checkout week5
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Verify Flutter setup**
   ```bash
   flutter doctor
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

### Quick Start Commands

```bash
# Clean build (if facing issues)
flutter clean
flutter pub get
flutter run

# Run on specific device
flutter devices                # List available devices
flutter run -d <device-id>    # Run on specific device

# Build for release
flutter build apk             # Android
flutter build ios             # iOS
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0              # HTTP networking library
  cupertino_icons: ^1.0.2   # iOS style icons

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0     # Recommended lints for Flutter
```

### Package Details

- **http (^1.1.0)**: A composable, cross-platform library for making HTTP requests
  - Used for GET requests to JSONPlaceholder API
  - Handles network timeouts and error responses
  - Supports async/await patterns

## 🌐 API Integration

### JSONPlaceholder API

The app uses the free [JSONPlaceholder](https://jsonplaceholder.typicode.com/) API for testing and prototyping.

**Base URL**: `https://jsonplaceholder.typicode.com`

### Endpoints Used

| Endpoint | Method | Description | Response |
|----------|--------|-------------|----------|
| `/users` | GET | Fetch all users | Array of user objects |
| `/users/:id` | GET | Fetch specific user | Single user object |
| `/posts?userId=:id` | GET | Fetch user's posts | Array of post objects |

### Sample API Response

```json
{
  "id": 1,
  "name": "Leanne Graham",
  "username": "Bret",
  "email": "Sincere@april.biz",
  "address": {
    "street": "Kulas Light",
    "suite": "Apt. 556",
    "city": "Gwenborough",
    "zipcode": "92998-3874",
    "geo": {
      "lat": "-37.3159",
      "lng": "81.1496"
    }
  },
  "phone": "1-770-736-8031 x56442",
  "website": "hildegard.org",
  "company": {
    "name": "Romaguera-Crona",
    "catchPhrase": "Multi-layered client-server neural-net",
    "bs": "harness real-time e-markets"
  }
}
```

## ✅ Week 4 Requirements

### Requirement 1: HTTP Requests and JSON Parsing ✅

**Implementation:**
- Uses `http` package for making GET requests
- Fetches user data from JSONPlaceholder API
- Parses JSON responses into strongly-typed Dart objects
- Implements data models with factory constructors
- Displays data in a ListView with custom ListTile widgets

**Files:**
- `lib/services/api_service.dart` - API service class
- `lib/models/user_model.dart` - User data models

### Requirement 2: User Profile Screen ✅

**Implementation:**
- Dedicated screen for displaying detailed user information
- Fetches and displays:
  - Name, username, email
  - Phone number and website
  - Complete address (street, suite, city, zipcode, coordinates)
  - Company information (name, catchphrase, business)
  - User's posts count
- Beautiful gradient header with user avatar
- Organized sections with Material Design cards

**File:**
- `lib/screens/user_profile_screen.dart`

### Requirement 3: Error Handling and Loading Indicators ✅

**Implementation:**

**Loading States:**
- CircularProgressIndicator during data fetch
- Pull-to-refresh loading indicator
- Smooth loading transitions

**Error Handling:**
- Network connectivity errors
- Request timeout handling (10 seconds)
- HTTP status code errors (4xx, 5xx)
- JSON parsing errors
- Specific error messages for each error type

**User Feedback:**
- Clear error messages with icons
- Retry buttons on error screens
- Toast/snackbar notifications
- Visual error states

**Files:**
- Error handling in `lib/services/api_service.dart`
- UI error states in `lib/screens/home_screen.dart`

## 🔧 Technical Implementation

### 1. HTTP Service Layer

```dart
class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  
  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        // Parse JSON
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timeout');
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
```

### 2. Data Models

```dart
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: Address.fromJson(json['address']),
      phone: json['phone'],
      website: json['website'],
      company: Company.fromJson(json['company']),
    );
  }
}
```

### 3. State Management

Uses Flutter's built-in `setState()` for managing:
- Loading states (`_isLoading`)
- Error states (`_error`)
- Data state (`_users`, `_posts`)

### 4. Navigation

Implements Hero animations for smooth transitions:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => UserProfileScreen(user: user),
  ),
);
```

## 🧪 Testing

### Manual Testing Checklist

**Basic Functionality:**
- [ ] App launches successfully
- [ ] Loading indicator appears on initial load
- [ ] Users list displays correctly
- [ ] Can tap on user to view profile
- [ ] Profile screen shows all user details
- [ ] Back navigation works properly

**Refresh Functionality:**
- [ ] Pull-to-refresh works on home screen
- [ ] AppBar refresh button works
- [ ] Loading indicator appears during refresh
- [ ] Data updates after refresh

**Error Handling:**
- [ ] Turn off internet → See appropriate error message
- [ ] Turn on internet → Retry works
- [ ] Timeout error displays properly
- [ ] Server error (if any) handled gracefully

**UI/UX:**
- [ ] Animations are smooth
- [ ] Colors render correctly
- [ ] Text is readable
- [ ] Buttons are responsive
- [ ] Layout adapts to screen size

### Testing Error Scenarios

1. **No Internet Connection:**
   - Turn off WiFi/mobile data
   - Open the app or pull to refresh
   - Verify error message: "No internet connection"
   - Turn on internet
   - Tap "Try Again"
   - Verify data loads successfully

2. **Request Timeout:**
   - Use very slow internet connection
   - Wait for timeout (10 seconds)
   - Verify timeout error message appears
   - Tap retry
   - Verify retry works

## 🔍 Troubleshooting

### Common Issues and Solutions

**Issue: Red squiggly lines in code**
```bash
flutter pub get
```

**Issue: Build errors**
```bash
flutter clean
flutter pub get
flutter run
```

**Issue: Package version conflicts**
```bash
flutter pub upgrade
```

**Issue: Import errors**
- Ensure all files are in correct folders
- Run `flutter pub get`
- Restart your IDE

**Issue: App won't connect to API**
- Check internet connection
- Verify API endpoint is accessible
- Check for any proxy/firewall issues
- Ensure permissions are granted (Android: Internet permission)

**Issue: Slow performance**
- Run in release mode: `flutter run --release`
- Check for memory leaks
- Optimize images and assets

### Android Permissions

The app requires internet permission. Ensure it's added in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🎓 Learning Outcomes

By studying this project, you will learn:

1. **Networking in Flutter**
   - Making HTTP GET requests
   - Handling async operations
   - Working with futures and async/await

2. **JSON Handling**
   - Parsing JSON responses
   - Creating data models
   - Using factory constructors
   - Nested object parsing

3. **Error Management**
   - Try-catch blocks
   - Exception handling
   - Timeout handling
   - Network error detection
   - User feedback for errors

4. **State Management**
   - Using setState()
   - Managing loading states
   - Handling error states
   - Refresh state management

5. **UI Development**
   - Material Design principles
   - ListView implementation
   - Custom widgets
   - Navigation
   - Hero animations
   - Responsive layouts

6. **Best Practices**
   - Code organization
   - Separation of concerns
   - Clean architecture patterns
   - Documentation
   - Error handling patterns

## 🚀 Future Enhancements

Potential improvements for future versions:

- [ ] Add local caching with shared_preferences
- [ ] Implement Provider for state management
- [ ] Add search functionality
- [ ] Implement filtering and sorting
- [ ] Add dark mode support
- [ ] Include user posts in profile
- [ ] Add pagination for large datasets
- [ ] Implement offline mode
- [ ] Add unit and widget tests
- [ ] Include accessibility features

## 📄 License

This project is created for educational purposes as part of the Flutter Developers Internship Program.


## 🙏 Acknowledgments

- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) - Free fake REST API for testing
- [Flutter Documentation](https://flutter.dev/docs) - Official Flutter documentation
- [Material Design 3](https://m3.material.io/) - Design guidelines
- Flutter Developers Internship Program

---

**Built with ❤️ using Flutter**

For questions or support, please create an issue in the repository.
