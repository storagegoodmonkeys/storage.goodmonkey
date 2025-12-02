# Fix Supabase Email Verification Redirect URL

## Problem
Verification emails are pointing to a local server (localhost) instead of your iOS app.

## Solution
Configure the redirect URL in your Supabase dashboard to work with your iOS app.

## Steps to Fix:

### Option 1: Use App URL Scheme (Recommended for Testing)

1. **Find your app's Bundle Identifier:**
   - Open your Xcode project
   - Select the project in Navigator
   - Go to "Signing & Capabilities" tab
   - Find "Bundle Identifier" (should be something like `com.yourcompany.flick`)

2. **Configure URL Scheme in Xcode:**
   - In Xcode, go to your project target
   - Select "Info" tab
   - Expand "URL Types"
   - Click "+" to add a new URL Type
   - Set:
     - **Identifier**: `com.flick.app`
     - **URL Schemes**: `flick` (or your bundle identifier)

3. **Update Supabase Redirect URL:**
   - Go to: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/url-configuration
   - Or: Dashboard → Authentication → URL Configuration
   - In "Redirect URLs", add:
     ```
     flick://auth/callback
     ```
   - Or use your bundle identifier:
     ```
     com.yourcompany.flick://auth/callback
     ```

### Option 2: Disable Email Confirmation (For Testing Only)

1. **In Supabase Dashboard:**
   - Go to: Authentication → Settings
   - Find "Enable email confirmations"
   - **Turn OFF** email confirmation
   - Click "Save"

   ⚠️ **Note:** This is ONLY for testing. Re-enable before production!

### Option 3: Use a Web Redirect Page (Best for Production)

1. **Create a simple web page** that handles the verification and redirects to your app

2. **In Supabase, set redirect URL to:**
   ```
   https://yourdomain.com/auth/callback
   ```

3. **The web page should:**
   - Verify the email
   - Redirect to your app using deep link: `flick://auth/verified`

## Current Supabase Project:
- **URL**: https://kjhhwrvduqxprweqxhbo.supabase.co
- **Dashboard**: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo

## Recommended Quick Fix (For Now):

**Disable email confirmation temporarily for testing:**

1. Go to: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/providers
2. Click on "Email" provider
3. **Uncheck** "Enable email confirmations"
4. Click "Save"

This allows users to sign up and immediately sign in without email verification.

⚠️ **Remember to re-enable it before production!**

