# How to Run Twoglobes App on Another PC - Complete Guide

## 📋 Prerequisites

Before starting, make sure you have:
- ✅ Git installed on both PCs
- ✅ Flutter installed on the other PC
- ✅ GitHub account (or GitLab/Bitbucket)
- ✅ Internet connection

---

## Part 1: Upload to Git Repository (On Your Current PC)

### Step 1: Install Git (if not installed)

1. Download Git: https://git-scm.com/download/win
2. Install with default settings
3. Restart your terminal/PowerShell

### Step 2: Verify Git Installation

Open PowerShell and run:
```bash
git --version
```

You should see: `git version 2.x.x`

### Step 3: Navigate to Your Project Folder

```bash
cd C:\Users\r_mis\OneDrive\Desktop\TWO_GLOBES
```

### Step 4: Initialize Git Repository

```bash
git init
```

### Step 5: Add All Files

```bash
git add .
```

### Step 6: Create First Commit

```bash
git commit -m "Initial commit: Twoglobes Flutter app with Auth0 integration"
```

### Step 7: Create GitHub Repository

**Option A: Using GitHub Website**
1. Go to: https://github.com/new
2. Repository name: `twoglobes-app` (or any name you like)
3. Description: "Twoglobes Mobile App - Flutter with Auth0"
4. Choose: **Public** or **Private**
5. **DO NOT** initialize with README, .gitignore, or license
6. Click "Create repository"

**Option B: Using GitHub CLI (if installed)**
```bash
gh repo create twoglobes-app --public --source=. --remote=origin --push
```

### Step 8: Connect to GitHub Repository

After creating the repo on GitHub, you'll see instructions. Run these commands:

```bash
# Replace YOUR_USERNAME with your GitHub username
git remote add origin https://github.com/YOUR_USERNAME/twoglobes-app.git

# Rename branch to main (if needed)
git branch -M main

# Push to GitHub
git push -u origin main
```

**If asked for credentials:**
- Username: Your GitHub username
- Password: Use a **Personal Access Token** (not your GitHub password)
  - Create token: https://github.com/settings/tokens
  - Click "Generate new token (classic)"
  - Select scopes: `repo` (full control)
  - Copy the token and use it as password

### Step 9: Verify Upload

1. Go to: `https://github.com/YOUR_USERNAME/twoglobes-app`
2. You should see all your files there!

---

## Part 2: Setup on Another PC

### Step 10: Install Flutter on Other PC

1. Download Flutter: https://flutter.dev/docs/get-started/install/windows
2. Extract to: `C:\src\flutter` (or any location)
3. Add to PATH:
   - Search "Environment Variables" in Windows
   - Edit "Path" under User variables
   - Add: `C:\src\flutter\bin`
   - Restart terminal

4. Verify installation:
```bash
flutter doctor
```

### Step 11: Install Git on Other PC (if not installed)

Same as Step 1 above.

### Step 12: Clone Repository

Open PowerShell on the other PC:

```bash
# Navigate to where you want the project
cd C:\Users\YourUsername\Desktop

# Clone the repository (replace YOUR_USERNAME)
git clone https://github.com/YOUR_USERNAME/twoglobes-app.git

# Navigate into the project
cd twoglobes-app
```

### Step 13: Create Flutter Project Structure

```bash
# Create Flutter project in a new folder
cd C:\Users\YourUsername\Desktop
flutter create two_globes_app
cd two_globes_app
```

### Step 14: Copy Files from Git Repository

**Using File Explorer:**
1. Go to: `C:\Users\YourUsername\Desktop\twoglobes-app\lib`
2. Copy ALL files (services, screens, widgets, main.dart)
3. Go to: `C:\Users\YourUsername\Desktop\two_globes_app\lib`
4. Paste and replace all files

**Or using PowerShell:**
```bash
Copy-Item -Path "C:\Users\YourUsername\Desktop\twoglobes-app\lib\*" -Destination "C:\Users\YourUsername\Desktop\two_globes_app\lib\" -Recurse -Force
```

### Step 15: Update pubspec.yaml

Open `two_globes_app\pubspec.yaml` and add:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  auth0_flutter: ^1.14.0
  http: ^1.1.0
  email_validator: ^2.1.17
  shared_preferences: ^2.2.2
```

### Step 16: Install Dependencies

```bash
cd C:\Users\YourUsername\Desktop\two_globes_app
flutter pub get
```

### Step 17: Enable Web Support

```bash
flutter config --enable-web
flutter create --platforms=web .
```

### Step 18: Run the App

```bash
flutter run -d chrome
```

**Done!** Your app should open in Chrome! 🎉

---

## Quick Reference Commands

### On Current PC (Upload):
```bash
cd C:\Users\r_mis\OneDrive\Desktop\TWO_GLOBES
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR_USERNAME/twoglobes-app.git
git branch -M main
git push -u origin main
```

### On Other PC (Download):
```bash
cd C:\Users\YourUsername\Desktop
git clone https://github.com/YOUR_USERNAME/twoglobes-app.git
cd twoglobes-app
# Then follow steps 13-18 above
```

---

## Troubleshooting

### Problem: "Repository not found"
- Check your GitHub username is correct
- Make sure repository is Public (or you have access if Private)
- Verify the repository URL

### Problem: "Authentication failed"
- Use Personal Access Token instead of password
- Create token: https://github.com/settings/tokens

### Problem: "Flutter not found" on other PC
- Add Flutter to PATH
- Restart terminal
- Run `flutter doctor`

### Problem: "Package not found"
```bash
flutter clean
flutter pub get
```

---

## Alternative: Using GitHub Desktop (Easier Method)

If command line is difficult:

1. **Download GitHub Desktop:** https://desktop.github.com/
2. **Sign in** with your GitHub account
3. **Add existing repository:**
   - File → Add Local Repository
   - Select: `C:\Users\r_mis\OneDrive\Desktop\TWO_GLOBES`
4. **Publish repository:**
   - Click "Publish repository"
   - Choose name and visibility
   - Click "Publish repository"

On other PC:
1. Install GitHub Desktop
2. Sign in
3. Clone repository: File → Clone Repository
4. Select your repository and clone

---

## File Structure After Setup

```
two_globes_app/
├── lib/
│   ├── main.dart
│   ├── services/
│   │   └── auth_service.dart
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── forgot_password_screen.dart
│   │   ├── reset_password_screen.dart
│   │   ├── dashboard_screen.dart
│   │   └── account_screen.dart
│   └── widgets/
│       ├── custom_button.dart
│       └── custom_text_field.dart
├── pubspec.yaml
└── README.md
```

---

## Important Notes

1. **Keep repository updated:**
   - When you make changes, commit and push:
   ```bash
   git add .
   git commit -m "Description of changes"
   git push
   ```

2. **On other PC, pull latest changes:**
   ```bash
   git pull
   ```

3. **Auth0 Configuration:**
   - Same Auth0 credentials work on all PCs
   - No need to change anything in `auth_service.dart`

4. **Dependencies:**
   - Always run `flutter pub get` after cloning
   - If errors occur, run `flutter clean` first

---

## Success Checklist

- ✅ Git repository created and files uploaded
- ✅ Flutter installed on other PC
- ✅ Repository cloned successfully
- ✅ Files copied to Flutter project
- ✅ Dependencies installed
- ✅ Web support enabled
- ✅ App runs on Chrome

You're all set! 🚀

