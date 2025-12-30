# Step-by-Step: Upload to Git & Run on Another PC

## 🎯 Part 1: Upload to GitHub (Current PC)

### Step 1: Open PowerShell
- Press `Windows Key + X`
- Select "Windows PowerShell" or "Terminal"

### Step 2: Navigate to Project Folder
```bash
cd C:\Users\r_mis\OneDrive\Desktop\TWO_GLOBES
```

### Step 3: Initialize Git Repository
```bash
git init
```

### Step 4: Add All Files
```bash
git add .
```

### Step 5: Create First Commit
```bash
git commit -m "Initial commit: Twoglobes Flutter app"
```

### Step 6: Create GitHub Repository

**Option A: Using GitHub Website (Recommended)**

1. Go to https://github.com
2. Sign in (or create account)
3. Click the **"+"** icon (top right)
4. Click **"New repository"**
5. Fill in:
   - **Repository name**: `two_globes` (or any name)
   - **Description**: "Twoglobes Mobile App"
   - **Visibility**: Public or Private (your choice)
   - **DO NOT** check "Initialize with README" (we already have files)
6. Click **"Create repository"**

**Option B: Using GitHub CLI**
```bash
gh repo create two_globes --public --source=. --remote=origin --push
```

### Step 7: Connect to GitHub

After creating repository, GitHub will show you commands. Use these:

```bash
# Replace YOUR_USERNAME with your actual GitHub username
git remote add origin https://github.com/YOUR_USERNAME/two_globes.git

# Rename branch to main
git branch -M main

# Push to GitHub
git push -u origin main
```

**If asked for credentials:**
- Username: Your GitHub username
- Password: Use a **Personal Access Token** (not your GitHub password)
  - Create token: GitHub → Settings → Developer settings → Personal access tokens → Generate new token
  - Give it "repo" permissions

### Step 8: Verify Upload

1. Go to your GitHub repository page
2. You should see all files:
   - ✅ `lib/` folder
   - ✅ `pubspec.yaml`
   - ✅ `README.md`
   - ✅ All `.md` documentation files

**✅ Part 1 Complete! Your code is on GitHub!**

---

## 🎯 Part 2: Setup on Another PC

### Step 1: Install Flutter

1. **Download Flutter:**
   - Go to: https://flutter.dev/docs/get-started/install/windows
   - Download Flutter SDK (ZIP file)

2. **Extract Flutter:**
   - Extract to `C:\src\flutter` (or any location)
   - **Important**: No spaces in path!

3. **Add to PATH:**
   - Press `Windows Key`, search "Environment Variables"
   - Click "Edit the system environment variables"
   - Click "Environment Variables"
   - Under "User variables", find "Path", click "Edit"
   - Click "New", add: `C:\src\flutter\bin`
   - Click OK on all windows
   - **Restart terminal**

4. **Verify:**
   ```bash
   flutter --version
   ```

### Step 2: Install Git (if not installed)

1. Download: https://git-scm.com/download/win
2. Install with default settings
3. Restart terminal
4. Verify: `git --version`

### Step 3: Clone Repository

```bash
# Navigate to Desktop
cd C:\Users\YourUsername\Desktop

# Clone repository (replace YOUR_USERNAME)
git clone https://github.com/YOUR_USERNAME/two_globes.git

# Navigate into project
cd two_globes
```

### Step 4: Install Dependencies

```bash
# Get all Flutter packages
flutter pub get

# Enable web support
flutter config --enable-web

# Create web platform files
flutter create --platforms=web .
```

### Step 5: Run the App

```bash
# Run on Chrome
flutter run -d chrome
```

**What happens:**
- Flutter compiles (first time: 2-3 minutes)
- Chrome opens automatically
- App loads at `http://localhost:xxxxx`
- You see the Login screen!

### Step 6: Stop the App

- Press `q` in terminal to quit
- Or close Chrome window

---

## ✅ Quick Verification Checklist

### On Current PC (After Upload):
- [ ] Git repository initialized
- [ ] Files committed
- [ ] Pushed to GitHub
- [ ] Can see files on GitHub website

### On New PC (After Setup):
- [ ] Flutter installed and in PATH
- [ ] Git installed
- [ ] Repository cloned
- [ ] Dependencies installed (`flutter pub get` successful)
- [ ] App runs on Chrome (`flutter run -d chrome` works)
- [ ] Login screen appears

---

## 🐛 Common Issues & Solutions

### Issue: "Flutter command not found"
**Fix:** Add Flutter to PATH, restart terminal

### Issue: "Git command not found"
**Fix:** Install Git, restart terminal

### Issue: "Repository not found" when cloning
**Fix:** 
- Check repository URL is correct
- Make sure repository is Public (or you have access)
- Verify repository exists on GitHub

### Issue: "Authentication failed" when pushing
**Fix:**
- Use Personal Access Token instead of password
- Create token: GitHub → Settings → Developer settings → Personal access tokens

### Issue: "No devices found"
**Fix:**
```bash
flutter config --enable-web
flutter devices
```

### Issue: "Package not found"
**Fix:**
```bash
flutter clean
flutter pub get
```

---

## 📚 Documentation Files Reference

- **SETUP_ON_NEW_PC.md** - Detailed setup guide for new PC
- **HOW_TO_RUN.md** - How to run the app
- **GIT_SETUP.md** - Git repository setup details
- **README.md** - Project overview
- **COMPLETE_SETUP_GUIDE.md** - Complete guide index

---

## 🎉 Success!

Once you complete both parts:
- ✅ Code is safely stored on GitHub
- ✅ Can clone on any PC
- ✅ App runs successfully
- ✅ All features work

**You're all set! 🚀**

