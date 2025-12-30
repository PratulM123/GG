# Twoglobes Mobile App

A Flutter application for IoT device management with Auth0 authentication integration.

## 📱 Features

- ✅ **Authentication**: Login, Signup, Forgot Password, Reset Password
- ✅ **Auth0 Integration**: Secure authentication with PKCE flow
- ✅ **Group Management**: Create and manage device groups
- ✅ **Account Settings**: Language preferences
- ✅ **Modern UI**: Clean, responsive design with Material Design 3
- ✅ **API Integration**: Connect to Twoglobes backend API

## 🚀 Quick Start

### Prerequisites

1. **Flutter SDK** (3.8.1 or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   - Verify: `flutter doctor`

2. **Development Tools**
   - VS Code or Android Studio with Flutter extensions
   - Chrome browser (for web development)

### Installation

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd two_globes
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Enable web support:**
   ```bash
   flutter config --enable-web
   flutter create --platforms=web .
   ```

4. **Run the app:**
   ```bash
   flutter run -d chrome
   ```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── services/
│   └── auth_service.dart    # Auth0 & API integration
├── screens/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── forgot_password_screen.dart
│   ├── reset_password_screen.dart
│   ├── dashboard_screen.dart
│   └── account_screen.dart
└── widgets/
    ├── custom_button.dart
    └── custom_text_field.dart
```

## 🔧 Configuration

### Auth0 Settings

All Auth0 configuration is in `lib/services/auth_service.dart`:

- **Domain**: `twoglobes.eu.auth0.com`
- **Client ID**: `x2pVfwSjjxqZGIGtcIEani5naU9VnotX`
- **Audience**: `https://api-staging.twoglobes.com/`
- **API Base URL**: `https://api-staging.twoglobes.com/mobile`

### API Endpoints

- `POST /mobile/groups` - Create a group
- `GET /mobile/groups` - List user's groups
- `POST /mobile/groups/{id}/devices/by-guid/{guid}` - Link device to group

## 🎨 Design

- Material Design 3
- Purple primary buttons (`#8C4BFF`)
- Blue accent colors
- Responsive layouts

## 📱 Running on Different Platforms

### Web (Chrome)
```bash
flutter run -d chrome
```

### Android
```bash
flutter run -d android
```

### iOS (macOS only)
```bash
flutter run -d ios
```

## 🔒 Security

- Secure token storage via Auth0 CredentialsManager
- Automatic token refresh
- 401 retry logic
- No client secrets in mobile code

## 📝 Dependencies

- `auth0_flutter: ^1.14.0` - Auth0 authentication
- `http: ^1.1.0` - HTTP requests
- `email_validator: ^2.1.17` - Email validation
- `shared_preferences: ^2.2.2` - Local storage

## 🐛 Troubleshooting

### Common Issues

1. **Flutter not found:**
   - Add Flutter to your PATH
   - Restart terminal

2. **Dependencies error:**
   ```bash
   flutter clean
   flutter pub get
   ```

3. **Web support not enabled:**
   ```bash
   flutter config --enable-web
   flutter create --platforms=web .
   ```

## 📄 License

This project is for Twoglobes IoT device management.

## 👥 Contributors

- Developed for Twoglobes

---

**Note**: Make sure to configure Auth0 dashboard with correct callback URLs for web platform.
