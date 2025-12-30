# How to Run Twoglobes Flutter App - Step by Step Guide

## Prerequisites Check

### Step 1: Check if Flutter is Installed

Open PowerShell or Command Prompt and run:
```bash
flutter --version
```

**If Flutter is NOT installed:**
1. Download Flutter from: https://flutter.dev/docs/get-started/install/windows
2. Extract the zip file to `C:\src\flutter` (or any location you prefer)
3. Add Flutter to your PATH:
   - Search for "Environment Variables" in Windows
   - Click "Environment Variables"
   - Under "User variables", find "Path" and click "Edit"
   - Click "New" and add: `C:\src\flutter\bin` (or your Flutter path)
   - Click OK on all windows
   - **Restart your terminal/PowerShell**

### Step 2: Verify Flutter Installation

```bash
flutter doctor
```

This will show what's installed and what's missing. You need at least:
- ✅ Flutter (Channel stable)
- ✅ Chrome (for web development)

---

## Setup Your Flutter Project

### Step 3: Create a New Flutter Project

Open PowerShell/Command Prompt and run:

```bash
# Navigate to Desktop
cd C:\Users\r_mis\OneDrive\Desktop

# Create new Flutter project
flutter create two_globes_app

# Navigate into the project
cd two_globes_app
```

### Step 4: Copy Your Code Files

**Option A: Manual Copy (Recommended)**
1. Open File Explorer
2. Go to: `C:\Users\r_mis\OneDrive\Desktop\TWO_GLOBES\lib`
3. Copy ALL files and folders from `TWO_GLOBES\lib\` to `two_globes_app\lib\`
4. Replace any existing files if asked

**Option B: Using PowerShell**
```bash
# From TWO_GLOBES folder, copy all files
Copy-Item -Path "C:\Users\r_mis\OneDrive\Desktop\TWO_GLOBES\lib\*" -Destination "C:\Users\r_mis\OneDrive\Desktop\two_globes_app\lib\" -Recurse -Force
```

### Step 5: Update pubspec.yaml

Open `two_globes_app\pubspec.yaml` and add these dependencies under `dependencies:`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  # Add these lines:
  auth0_flutter: ^1.14.0
  http: ^1.1.0
  email_validator: ^2.1.17
  shared_preferences: ^2.2.2
```

**Save the file** after adding dependencies.

### Step 6: Enable Web Support

In PowerShell (still in your project folder):

```bash
# Enable web support
flutter config --enable-web

# Create web platform files
flutter create --platforms=web .
```

### Step 7: Install Dependencies

```bash
# Make sure you're in the project folder
cd C:\Users\r_mis\OneDrive\Desktop\two_globes_app

# Install all packages
flutter pub get
```

Wait for it to finish. You should see: "Got dependencies!"

---

## Run the App

### Step 8: Run on Chrome

```bash
# Make sure you're in the project folder
cd C:\Users\r_mis\OneDrive\Desktop\two_globes_app

# Run the app
flutter run -d chrome
```

**What happens:**
1. Flutter will compile your app
2. Chrome browser will open automatically
3. Your app will load at `http://localhost:xxxxx`
4. You'll see the Login screen!

### Step 9: Stop the App

- Press `q` in the terminal to quit
- Or close the Chrome window

---

## Alternative: Run on Web Server

If Chrome doesn't work, try:

```bash
flutter run -d web-server --web-port=8080
```

Then open your browser and go to: `http://localhost:8080`

---

## Troubleshooting

### Problem: "Flutter command not found"
**Solution:** 
- Flutter is not in your PATH
- Follow Step 1 again to add Flutter to PATH
- Restart your terminal

### Problem: "No devices found"
**Solution:**
```bash
flutter config --enable-web
flutter devices
```

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

### Problem: Chrome doesn't open
**Solution:**
- Make sure Chrome is installed
- Or use: `flutter run -d web-server`
- Then manually open: `http://localhost:xxxxx`

---

## Quick Reference Commands

```bash
# Navigate to project
cd C:\Users\r_mis\OneDrive\Desktop\two_globes_app

# Clean build (if having issues)
flutter clean

# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome

# Check Flutter setup
flutter doctor

# List available devices
flutter devices
```

---

## Expected Result

When you run `flutter run -d chrome`:

1. ✅ Terminal shows: "Launching lib/main.dart on Chrome in debug mode..."
2. ✅ Chrome browser opens automatically
3. ✅ You see the Twoglobes Login screen
4. ✅ You can test:
   - Login
   - Signup
   - Forgot Password
   - Account Settings

---

## Next Steps After Running

1. **Test Login Flow:**
   - Try logging in (will use Auth0)
   - Try registering a new account
   - Test forgot password

2. **Test Dashboard:**
   - After login, you'll see the dashboard
   - Try creating a group
   - Click Account icon to see Account page

3. **Hot Reload:**
   - While app is running, edit any `.dart` file
   - Save the file
   - Press `r` in terminal for hot reload
   - Or press `R` for hot restart

---

## Need Help?

If you encounter any errors:
1. Copy the error message
2. Check `flutter doctor` output
3. Make sure all dependencies are installed
4. Try `flutter clean` then `flutter pub get`

Good luck! 🚀

