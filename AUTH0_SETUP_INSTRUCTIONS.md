# Auth0 Callback URL Configuration - REQUIRED

## ⚠️ IMPORTANT: You must configure this in Auth0 Dashboard

The app is using the callback URL format:
```
https://twoglobes.eu.auth0.com/android/com.example.global_globe/callback
```

## Steps to Fix Callback URL Mismatch Error:

1. **Go to Auth0 Dashboard:**
   - Login to: https://manage.auth0.com
   - Navigate to: Applications → Your App (Client ID: x2pVfwSjjxqZGIGtcIEani5naU9VnotX)

2. **Add Allowed Callback URLs:**
   - Go to "Settings" tab
   - Scroll to "Allowed Callback URLs"
   - Add these URLs (one per line):
     ```
     https://twoglobes.eu.auth0.com/android/com.example.global_globe/callback
     com.example.global_globe://twoglobes.eu.auth0.com/android/com.example.global_globe/callback
     ```

3. **Add Allowed Logout URLs:**
   - Scroll to "Allowed Logout URLs"
   - Add:
     ```
     com.example.global_globe://twoglobes.eu.auth0.com/android/com.example.global_globe/callback
     ```

4. **Enable Grant Types:**
   - Scroll to "Application Properties"
   - Make sure these are enabled:
     - ✅ Authorization Code
     - ✅ Refresh Token
     - ✅ Password (if using email/password login)

5. **Set Application Type:**
   - For mobile apps, set to "Native" application type
   - This enables PKCE automatically

6. **Save Changes:**
   - Click "Save Changes" at the bottom

## After Configuration:

1. Restart the app
2. Try logging in again
3. The callback URL mismatch error should be resolved

## For Email/Password Login (401 Error):

If you're getting 401 errors with email/password login:

1. **Check Grant Type:**
   - The app uses: `http://auth0.com/oauth/grant-type/password-realm`
   - Make sure "Password" grant type is enabled in Auth0

2. **Check Database Connection:**
   - Go to Authentication → Database
   - Ensure "Username-Password-Authentication" connection exists
   - Make sure it's enabled for your application

3. **Verify User Exists:**
   - Check that the user account exists in Auth0
   - User Management → Users → Search for the email

## Current Configuration:

- **Domain:** twoglobes.eu.auth0.com
- **Client ID:** x2pVfwSjjxqZGIGtcIEani5naU9VnotX
- **Audience:** https://api-staging.twoglobes.com/
- **Scheme:** com.example.global_globe (configured in build.gradle.kts)
- **Package:** com.example.global_globe

