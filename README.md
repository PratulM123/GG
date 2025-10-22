# Twoglobes Mobile App

A Flutter application for IoT device management with Auth0 authentication integration.

## Features

- **Authentication**: Login, Signup, and Forgot Password screens
- **Auth0 Integration**: Secure authentication with PKCE flow
- **Group Management**: Create and manage device groups
- **Modern UI**: Clean, responsive design with Material Design 3
- **API Integration**: Connect to Twoglobes backend API

## Screenshots

The app includes:
- Login Screen with email/password authentication
- Signup Screen with form validation
- Forgot Password Screen with email reset
- Dashboard Screen with group management

## Setup Instructions

### Prerequisites

1. **Flutter SDK**: Install Flutter (version 3.8.1 or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   - Verify installation: `flutter doctor`

2. **Development Environment**:
   - Android Studio or VS Code with Flutter extensions
   - Android SDK (for Android development)
   - Xcode (for iOS development, macOS only)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Tanya0605/Global-Globe.git
   cd Global-Globe
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

### For Android Development

1. Enable USB debugging on your Android device
2. Connect your device via USB
3. Run: `flutter run`

### For iOS Development (macOS only)

1. Open `ios/Runner.xcworkspace` in Xcode
2. Configure signing and certificates
3. Run: `flutter run`

## Collaboration Setup

### For You (Ravi)

1. **Clone your colleague's repository**:
   ```bash
   git clone https://github.com/Tanya0605/Global-Globe.git
   cd Global-Globe
   ```

2. **Add your repository as a remote**:
   ```bash
   git remote add my-repo https://github.com/PratulM123/GG.git
   ```

3. **Pull latest changes from colleague**:
   ```bash
   git pull origin main
   ```

4. **Push your changes to your repository**:
   ```bash
   git push my-repo main
   ```

### For Your Colleague (Tanya)

1. **Add your repository as a remote**:
   ```bash
   git remote add ravi-repo https://github.com/PratulM123/GG.git
   ```

2. **Pull your changes**:
   ```bash
   git pull ravi-repo colleague-main
   ```

3. **Merge changes**:
   ```bash
   git checkout main
   git merge colleague-main
   git push origin main
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/                  # UI screens
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── forgot_password_screen.dart
│   └── dashboard_screen.dart
├── services/                 # Business logic
│   └── auth_service.dart
├── widgets/                  # Reusable UI components
│   ├── custom_button.dart
│   └── custom_text_field.dart
├── models/                   # Data models
└── utils/                    # Utility functions
```

## Authentication Configuration

The app is configured to use Auth0 with the following settings:

- **Domain**: `twoglobes.eu.auth0.com`
- **Client ID**: `x2pVfwSjjxqZGIGtcIEani5naU9VnotX`
- **Audience**: `https://api-staging.twoglobes.com/`
- **Scopes**: `openid`, `profile`, `email`

## API Integration

The app integrates with the Twoglobes backend API:

- **Base URL**: `https://api-staging.twoglobes.com/mobile`
- **Authentication**: Bearer token from Auth0
- **Endpoints**:
  - `POST /groups` - Create a group
  - `GET /groups` - List user's groups
  - `POST /groups/{id}/devices/by-guid/{guid}` - Link device to group

## Development Workflow

1. **Make changes** to the code
2. **Test locally**: `flutter run`
3. **Commit changes**: `git add . && git commit -m "Description"`
4. **Push to your repository**: `git push my-repo main`
5. **Notify colleague** to pull your changes

## Troubleshooting

### Common Issues

1. **Dependencies not found**:
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Build errors**:
   ```bash
   flutter doctor
   flutter upgrade
   ```

3. **Authentication issues**:
   - Check Auth0 configuration
   - Verify network connectivity
   - Check API endpoints

### Getting Help

- Flutter Documentation: https://flutter.dev/docs
- Auth0 Flutter SDK: https://pub.dev/packages/auth0_flutter
- Twoglobes API Documentation: See provided API guide

## Next Steps

1. **Test the authentication flow**
2. **Implement device scanning/pairing**
3. **Add real-time device status updates**
4. **Implement push notifications**
5. **Add user profile management**

## Contributing

1. Create a feature branch
2. Make your changes
3. Test thoroughly
4. Commit with descriptive messages
5. Push to your repository
6. Coordinate with colleague for integration

---

**Note**: This is a collaborative project. Always communicate with your colleague before making major changes to ensure smooth development workflow.