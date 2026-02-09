# 🚀 Flutter Week 4 - API Integration & Networking

A beautifully designed Flutter application demonstrating API integration, JSON parsing, error handling, and loading indicators.

[![Flutter Version](https://img.shields.io/badge/Flutter-3.0%2B-blue.svg)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-3.0%2B-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## ✨ Beautiful Modern Design

This app features a **stunning, modern UI** with:
- 🎨 Vibrant color palette (Purple, Pink, Cyan, Yellow)
- 💫 Smooth animations and hero transitions
- 🎯 Clean card-based interface with Material Design 3
- 🌈 Gradient avatars with elegant shadows
- ✨ Professional typography and spacing

## 📱 Screenshots

### Home Screen
- Displays list of users from API
- Beautiful gradient avatars
- Pull-to-refresh functionality
- Clean, modern card design

### User Profile Screen
- Expandable gradient header
- Complete user information
- Contact, Address, Company sections
- Activity tracker with posts count

## ✅ Week 4 Requirements - All Implemented

### 1. HTTP Requests and JSON Parsing ✅
- Uses `http` package for API requests
- Fetches data from JSONPlaceholder API
- Parses JSON responses into Dart objects
- Displays data using ListView

### 2. User Profile Screen ✅
- Fetches detailed user information
- Displays name, email, phone, website
- Shows address and company details
- Includes user posts count

### 3. Error Handling and Loading Indicators ✅
- Robust error handling for failed requests
- Specific error messages for:
  - No internet connection
  - Request timeout (10 seconds)
  - Server errors
- Beautiful loading spinners
- Pull-to-refresh functionality
- Retry buttons on error screens

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- An emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/flutter_week4_app.git
   cd flutter_week4_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
flutter_week4_app/
├── lib/
│   ├── main.dart                      # App entry point
│   ├── models/
│   │   └── user_model.dart           # User data models
│   ├── services/
│   │   └── api_service.dart          # API service handler
│   ├── screens/
│   │   ├── home_screen.dart          # Users list screen
│   │   └── user_profile_screen.dart  # User profile details
│   └── utils/
│       └── constants.dart             # App constants
├── pubspec.yaml                       # Dependencies
├── README.md                          # This file
├── QUICK_START_GUIDE.md              # Setup guide
├── ARCHITECTURE.md                    # Architecture docs
├── DESIGN.md                          # Design guide
└── TROUBLESHOOTING.md                # Common issues
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0              # For making HTTP requests
  cupertino_icons: ^1.0.2   # iOS style icons
```

## 🎯 API Used

**JSONPlaceholder** - Free fake API for testing
- Base URL: `https://jsonplaceholder.typicode.com`
- Endpoints:
  - `GET /users` - Fetch all users
  - `GET /users/:id` - Fetch specific user
  - `GET /posts?userId=:id` - Fetch user's posts

## 💡 Key Features

### Beautiful UI/UX
- 🎨 Modern Material Design 3
- 🌈 Color-coded users (6 vibrant colors)
- 💫 Hero animations between screens
- ✨ Soft shadows and rounded corners
- 📱 Responsive layouts

### Robust Architecture
- 📁 Clean, modular code structure
- 🔄 Proper separation of concerns
- 📝 Well-documented code
- ✅ Follows Flutter best practices

### Comprehensive Error Handling
- 🌐 Network connectivity checks
- ⏱️ Request timeout handling
- 🔄 Retry functionality
- 📊 User-friendly error messages

## 🧪 Testing

### Manual Testing Checklist
- [ ] App launches successfully
- [ ] Loading indicator appears
- [ ] Users list loads from API
- [ ] Can tap on user to view profile
- [ ] Profile screen displays all info
- [ ] Pull-to-refresh works
- [ ] Error handling works (turn off internet)
- [ ] Retry button works

### Test Error Handling
1. Turn off internet/WiFi
2. Open the app or pull to refresh
3. See "No internet connection" error
4. Turn on internet
5. Tap "Try Again" button
6. Data loads successfully

## 📚 Documentation

- **README.md** (this file) - Overview and setup
- **QUICK_START_GUIDE.md** - Step-by-step setup
- **ARCHITECTURE.md** - Deep dive into architecture
- **DESIGN.md** - UI/UX design explanation
- **TROUBLESHOOTING.md** - Common issues and fixes

## 🎓 Learning Outcomes

By studying this project, you'll learn:
- ✅ HTTP requests in Flutter
- ✅ JSON parsing and data modeling
- ✅ State management with setState
- ✅ Error handling patterns
- ✅ Loading state management
- ✅ Navigation between screens
- ✅ ListView implementation
- ✅ Material Design principles
- ✅ Beautiful UI/UX design

## 🔧 Troubleshooting

### Common Issues

**Red squiggly lines in code?**
```bash
flutter pub get
```

**App won't build?**
```bash
flutter clean
flutter pub get
flutter run
```

**Import errors?**
- Make sure all files are in correct folders
- Run `flutter pub get`
- Restart your IDE

See **TROUBLESHOOTING.md** for detailed solutions.

## 🚀 Future Enhancements (Week 5 & 6)

- [ ] Firebase Authentication
- [ ] Cloud Firestore integration
- [ ] Provider state management
- [ ] Offline caching
- [ ] Push notifications
- [ ] Search functionality
- [ ] Dark mode support

## 👨‍💻 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)
- Email: your.email@example.com

**Flutter Developers Internship - Cycle 2**
- Week 4: API Integration and Networking
- Deadline: February 15, 2026

## 📄 License

This project is created for educational purposes as part of the Flutter Developers Internship Program.

## 🙏 Acknowledgments

- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) - Free fake API
- [Flutter Documentation](https://flutter.dev/docs)
- [Material Design 3](https://m3.material.io/)
- Flutter Developers Internship Program


### ✅ Week 4 Requirements Implemented

1. **HTTP Requests and JSON Parsing**
   - Uses `http` package for API requests
   - Fetches data from JSONPlaceholder API
   - Parses JSON responses into Dart objects
   - Displays data using ListView

2. **User Profile Screen**
   - Fetches and displays detailed user information
   - Shows name, email, phone, website
   - Displays address and company details
   - Shows user's posts count

3. **Error Handling and Loading Indicators**
   - Comprehensive error handling for network failures
   - Specific error messages for different failure types:
     - No internet connection
     - Request timeout
     - Server errors
   - Loading spinners while fetching data
   - Pull-to-refresh functionality
   - Retry button on error screens

## 🏗️ Project Structure

```
lib/
├── main.dart                      # App entry point
├── models/
│   └── user_model.dart           # User data model with JSON parsing
├── services/
│   └── api_service.dart          # API service for HTTP requests
└── screens/
    ├── home_screen.dart          # Users list screen
    └── user_profile_screen.dart  # User profile details screen
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- An emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd flutter_week4_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0              # For making HTTP requests
  cupertino_icons: ^1.0.2   # iOS style icons
```

## 🎯 API Endpoints Used

- **Base URL**: `https://jsonplaceholder.typicode.com`
- **GET /users** - Fetch all users
- **GET /users/:id** - Fetch specific user details
- **GET /posts?userId=:id** - Fetch user's posts

## 💡 Key Concepts Demonstrated

### 1. HTTP Requests
```dart
final response = await http.get(
  Uri.parse('$baseUrl/users'),
).timeout(const Duration(seconds: 10));
```

### 2. JSON Parsing
```dart
factory User.fromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    // ... other fields
  );
}
```

### 3. Error Handling
```dart
try {
  final users = await _apiService.fetchUsers();
  // Handle success
} catch (e) {
  // Handle errors with specific messages
  if (e.toString().contains('SocketException')) {
    throw Exception('No internet connection');
  }
}
```

### 4. Loading States
```dart
if (_isLoading) {
  return Center(
    child: CircularProgressIndicator(),
  );
}
```

## 📸 App Screenshots

### Home Screen
- Displays a list of all users from the API
- Shows user name, email, and phone
- Loading indicator while fetching data
- Pull-to-refresh functionality
- Error handling with retry button

### User Profile Screen
- Detailed user information display
- Contact information section
- Address details
- Company information
- User posts count
- Beautiful gradient header with user avatar

## 🎨 UI/UX Features

- **Material Design 3** theme
- **Responsive layouts** that work on different screen sizes
- **Smooth animations** and transitions
- **Intuitive navigation** between screens
- **Clear visual feedback** for all user actions
- **Professional card-based** design
- **Color-coded sections** for better readability

## 🔧 Error Handling

The app handles various error scenarios:

1. **No Internet Connection**: Detects network unavailability
2. **Request Timeout**: 10-second timeout for all requests
3. **Server Errors**: Handles HTTP status code errors
4. **Parsing Errors**: Manages JSON parsing failures

Each error displays:
- A clear error icon
- Descriptive error message
- Retry button to attempt the request again

## 🧪 Testing the App

### Test Cases

1. **Normal Operation**
   - Open app → See loading indicator → View users list
   - Tap on a user → See profile loading → View detailed profile

2. **Error Scenarios**
   - Turn off internet → See "No internet connection" error
   - Turn on internet → Tap retry → See data load successfully

3. **Refresh Functionality**
   - Pull down on users list → See refresh indicator → Data reloads
   - Tap refresh icon in AppBar → Data reloads

## 📚 Learning Outcomes

By completing this project, you will learn:

- ✅ How to make HTTP GET requests in Flutter
- ✅ JSON parsing and data modeling
- ✅ Proper error handling in async operations
- ✅ State management using setState
- ✅ Building responsive UI layouts
- ✅ ListView and ListTile widgets
- ✅ Navigation between screens
- ✅ Loading indicators and user feedback
- ✅ Material Design principles

## 🔜 Next Steps (Week 5 & 6)

- Integrate Firebase Authentication
- Add Firestore database
- Implement Provider for state management
- Add offline caching
- Implement push notifications


## 📄 License

This project is created for educational purposes as part of the Flutter Developers Internship Program.

---

## 🤝 Contributing

This is an internship project. If you find any issues or have suggestions:

1. Create an issue in the repository
2. Fork the project
3. Create a feature branch
4. Submit a pull request

---

**Note**: This app uses the free JSONPlaceholder API for demonstration purposes. No authentication is required.


---

**Happy Coding! 🚀**