# Git Repository Setup Guide

## Step 1: Initialize Git Repository

Open PowerShell in the TWO_GLOBES folder:

```bash
cd C:\Users\r_mis\OneDrive\Desktop\TWO_GLOBES
git init
```

## Step 2: Add All Files

```bash
git add .
```

## Step 3: Create Initial Commit

```bash
git commit -m "Initial commit: Twoglobes Flutter app with Auth0 integration"
```

## Step 4: Create GitHub Repository

### Option A: Using GitHub Website

1. Go to https://github.com
2. Sign in to your account
3. Click the "+" icon in top right
4. Select "New repository"
5. Repository name: `two_globes` (or any name you prefer)
6. Description: "Twoglobes Mobile App - IoT Device Management"
7. Choose Public or Private
8. **DO NOT** initialize with README, .gitignore, or license (we already have these)
9. Click "Create repository"

### Option B: Using GitHub CLI (if installed)

```bash
gh repo create two_globes --public --source=. --remote=origin --push
```

## Step 5: Connect Local Repository to GitHub

After creating the repository on GitHub, you'll see instructions. Use these commands:

```bash
# Add remote repository (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/two_globes.git

# Rename branch to main (if needed)
git branch -M main

# Push to GitHub
git push -u origin main
```

## Step 6: Verify Upload

1. Go to your GitHub repository page
2. You should see all your files:
   - `lib/` folder with all Dart files
   - `pubspec.yaml`
   - `README.md`
   - `.gitignore`
   - All documentation files

## Step 7: Clone on Another PC

On your other PC, run:

```bash
git clone https://github.com/YOUR_USERNAME/two_globes.git
cd two_globes
```

Then follow the `SETUP_ON_NEW_PC.md` guide.

---

## Quick Git Commands Reference

```bash
# Check status
git status

# Add all changes
git add .

# Commit changes
git commit -m "Your commit message"

# Push to GitHub
git push

# Pull latest changes
git pull

# View commit history
git log
```

---

## Important Files to Commit

Make sure these are included:
- ✅ `lib/` - All source code
- ✅ `pubspec.yaml` - Dependencies
- ✅ `README.md` - Documentation
- ✅ `.gitignore` - Git ignore rules
- ✅ `SETUP_ON_NEW_PC.md` - Setup guide
- ✅ `HOW_TO_RUN.md` - Running guide
- ✅ `IMPROVEMENTS_SUMMARY.md` - Changes summary

---

## Security Note

The `.gitignore` file excludes:
- Build files
- Environment variables
- Secret keys
- Platform-specific files

**Never commit:**
- `.env` files with secrets
- Auth0 client secrets
- API keys
- Personal credentials

---

## Troubleshooting

### Problem: "Repository not found"
- Check repository URL is correct
- Verify you have access to the repository
- Make sure repository exists on GitHub

### Problem: "Authentication failed"
- Use GitHub Personal Access Token instead of password
- Or use SSH keys for authentication

### Problem: "Large file" errors
- Check `.gitignore` is working
- Don't commit build files or large assets

---

**Your code is now safely stored on GitHub and ready to clone on any PC! 🎉**
