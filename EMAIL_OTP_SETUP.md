# 📧 Email OTP Verification Setup Guide

## What You Need to Do in Supabase

### Step 1: Enable Email Verification
1. Go to: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/providers
2. Click on **"Email"** provider
3. **ENABLE** "Enable email confirmations" (check the box)
4. **IMPORTANT**: Under "Email Templates", select or keep default template
5. Click **"Save"**

### Step 2: Configure Email Template (Optional but Recommended)
1. Still in Email provider settings
2. Click on **"Email Templates"** tab
3. Find **"Confirm signup"** template
4. You can customize the email message that contains the code
5. The code will be in the email - we'll extract it automatically in the app

### Step 3: Verify SMTP Settings (If Using Custom SMTP)
- If you're using default Supabase emails, you're good to go
- If using custom SMTP, ensure it's configured properly

## What the App Will Do

1. **User Signs Up** → Email with 6-digit code is sent
2. **User Enters Code** → App verifies the code with Supabase
3. **Code Verified** → User can sign in

## No Custom URL Scheme Needed

Unlike link-based verification, OTP codes don't require:
- ❌ Custom URL schemes
- ❌ Deep linking setup
- ❌ Redirect URLs

The user just:
- ✅ Receives email with code
- ✅ Enters code in app
- ✅ Gets verified

## Testing

1. Sign up with your email
2. Check your inbox for the verification code
3. Enter the code in the app
4. You'll be automatically signed in!

## That's It!

Once you enable email confirmations in Supabase, the app will automatically:
- Send codes when users sign up
- Show code entry screen
- Verify codes and sign users in

