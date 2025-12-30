# Setup Twoglobes App on a New PC - Complete Guide

## 📋 Prerequisites Checklist

Before starting, make sure you have:
- [ ] Internet connection
- [ ] Administrator access (for installing software)
- [ ] At least 2GB free disk space

---

## Step 1: Install Flutter SDK

### 1.1 Download Flutter

1. Go to: https://flutter.dev/docs/get-started/install/windows
2. Click "Download Flutter SDK"
3. Download the latest stable release (ZIP file)

### 1.2 Extract Flutter

1. Extract the ZIP file to `C:\src\flutter` (or any location you prefer)
   - **Important**: Don't extract to a folder with spaces or special characters
   - Good: `C:\src\flutter`
   - Bad: `C:\Program Files\flutter` or `C:\Users\Your Name\flutter`

### 1.3 Add Flutter to PATH

1. Press `Windows Key` and search for "Environment Variables"
2. Click "Edit the system environment variables"
3. Click "Environment Variables" button
4. Under "User variables", find "Path" and click "Edit"
5. Click "New" and add: `C:\src\flutter\bin` (or your Flutter path)
6. Click "OK" on all windows
7. **Close and reopen** your terminal/PowerShell

### 1.4 Verify Flutter Installation

Open **NEW** PowerShell/Command Prompt and run:

```bash
flutter --version
```

You should see Flutter version information. If you see "command not found", restart your computer.

### 1.5 Run Flutter Doctor

```bash
flutter doctor
```

This checks your setup. You need at least:
- ✅ Flutter (Channel stable)
- ✅ Chrome (for web development)

**Fix any issues shown by `flutter doctor`**

---

## Step 2: Install Git (if not installed)

### 2.1 Check if Git is Installed

```bash
git --version
```

If you see a version number, Git is installed. Skip to Step 3.

### 2.2 Install Git

1. Download from: https://git-scm.com/download/win
2. Run the installer
3. Use default settings (click Next through all steps)
4. Restart terminal after installation

### 2.3 Verify Git

```bash
git --version
```

---

## Step 3: Clone the Repository

### 3.1 Navigate to Desktop

```bash
cd C:\Users\YourUsername\Desktop
```

(Replace `YourUsername` with your actual Windows username)

### 3.2 Clone from GitHub

```bash
git clone https://github.com/YOUR_USERNAME/two_globes.git
```

**OR if you have the repository URL, use:**
```bash
git clone <your-repo-url>
```

### 3.3 Navigate to Project

```bash
cd two_globes
```

---

## Step 4: Install Dependencies

### 4.1 Get Flutter Packages

```bash
flutter pub get
```

Wait for it to finish. You should see: "Got dependencies!"

### 4.2 Enable Web Support

```bash
flutter config --enable-web
```

### 4.3 Create Web Platform Files

```bash
flutter create --platforms=web .
```

---

## Step 5: Run the App

### 5.1 Run on Chrome

```bash
flutter run -d chrome
```

**What happens:**
1. Flutter compiles your app (first time takes 2-3 minutes)
2. Chrome browser opens automatically
3. Your app loads at `http://localhost:xxxxx`
4. You'll see the Login screen!

### 5.2 Stop the App

- Press `q` in the terminal to quit
- Or close the Chrome window

---

## Step 6: Verify Everything Works

### Test Login Screen
- ✅ You see "Sign in or Register" screen
- ✅ Email and Password fields are visible
- ✅ Login, Google, Register, and Forgot Password buttons work

### Test Navigation
- ✅ Click "Register New Account" → Goes to Signup screen
- ✅ Click "Forgot Password" → Goes to Forgot Password screen
- ✅ Click back arrow → Returns to previous screen

---

## 🎯 Quick Command Reference

```bash
# Check Flutter version
flutter --version

# Check setup
flutter doctor

# Navigate to project
cd C:\Users\YourUsername\Desktop\two_globes

# Install dependencies
flutter pub get

# Enable web
flutter config --enable-web

# Run on Chrome
flutter run -d chrome

# Clean build (if issues)
flutter clean
flutter pub get
```

---

## 🐛 Troubleshooting

### Problem: "Flutter command not found"

**Solution:**
1. Verify Flutter is in PATH:
   - Run: `echo $env:PATH` (PowerShell) or `echo %PATH%` (CMD)
   - Should see `C:\src\flutter\bin` (or your path)
2. If not, re-add to PATH (Step 1.3)
3. **Restart terminal** or **restart computer**

### Problem: "Git command not found"

**Solution:**
1. Install Git (Step 2)
2. Restart terminal

### Problem: "No devices found" or "Chrome not found"

**Solution:**
```bash
flutter config --enable-web
flutter devices
```

If Chrome still not found:
- Install Google Chrome browser
- Or use: `flutter run -d web-server`

### Problem: "Package not found" errors

**Solution:**
```bash
flutter clean
flutter pub get
```

### Problem: "Web support not enabled"

**Solution:**
```bash
flutter config --enable-web
flutter create --platforms=web .
```

### Problem: "Unable to find git in your PATH"

**Solution:**
1. Install Git (Step 2)
2. Restart terminal
3. Run `flutter doctor` again

### Problem: App doesn't load in Chrome

**Solution:**
1. Check terminal for error messages
2. Try: `flutter run -d web-server --web-port=8080`
3. Manually open: `http://localhost:8080`

---

## 📱 Running on Other Platforms

### Android
```bash
# Enable Android
flutter config --enable-android

# Run on Android device/emulator
flutter run -d android
```

### iOS (macOS only)
```bash
# Enable iOS
flutter config --enable-ios

# Run on iOS simulator/device
flutter run -d ios
```

---

## ✅ Success Checklist

After setup, you should be able to:

- [ ] Run `flutter --version` successfully
- [ ] Run `flutter doctor` without critical errors
- [ ] Clone the repository
- [ ] Run `flutter pub get` successfully
- [ ] Run `flutter run -d chrome` and see the app
- [ ] See Login screen in Chrome
- [ ] Navigate between screens

---

## 🆘 Still Having Issues?

1. **Check Flutter Setup:**
   ```bash
   flutter doctor -v
   ```

2. **Check Internet Connection:**
   - Flutter needs internet to download packages

3. **Check Disk Space:**
   - Flutter needs at least 2GB free space

4. **Try Clean Install:**
   ```bash
   flutter clean
   flutter pub get
   flutter run -d chrome
   ```

5. **Check for Error Messages:**
   - Read terminal output carefully
   - Google the error message
   - Check Flutter documentation

---

## 📚 Additional Resources

- Flutter Documentation: https://flutter.dev/docs
- Flutter Installation Guide: https://flutter.dev/docs/get-started/install
- Auth0 Flutter SDK: https://pub.dev/packages/auth0_flutter

---

**Good luck! If you follow these steps, your app should run successfully! 🚀**

