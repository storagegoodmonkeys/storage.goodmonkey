# Fix Supabase Redirect URL

## Problem
The email verification is redirecting to `localhost:3000` which doesn't work. We need to update Supabase to use the correct URL.

## Steps to Fix

### Step 1: Go to URL Configuration
1. In Supabase dashboard, click **"URL Configuration"** in the left sidebar (under "CONFIGURATION")
2. It should open: `https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/url-configuration`

### Step 2: Update Site URL
1. Find the **"Site URL"** field
2. Change it from `http://localhost:3000` to:
   ```
   https://kjhhwrvduqxprweqxhbo.supabase.co
   ```
3. Or if there's a dropdown, select your project URL

### Step 3: Update Redirect URLs
1. Find the **"Redirect URLs"** section (usually a text area or list)
2. Add this URL:
   ```
   https://kjhhwrvduqxprweqxhbo.supabase.co/**
   ```
3. Remove or delete any `localhost:3000` entries if present
4. Keep other URLs that might be needed

### Step 4: Save Changes
- Click **"Save"** or **"Update"** button

## Also Fix Email Template (Important!)

The email is still sending a "Magic Link". You need to update the email template too:

1. Go to **"Email"** → **"Confirm sign up"** template
2. Change Subject to: `Confirm Your Signup - Code: {{ .Token }}`
3. Change Body to:
   ```html
   <h2>Confirm your signup</h2>
   <p>Your verification code is:</p>
   <h1 style="font-size: 36px; letter-spacing: 10px; text-align: center; color: #EF4444; font-weight: bold; margin: 20px 0;">{{ .Token }}</h1>
   <p>Enter this code in the app to verify your email.</p>
   <p>This code will expire in 1 hour.</p>
   ```
4. Click **"Save changes"**

## After Both Fixes

1. Try signing up again with a new email
2. Check your email inbox
3. You should see the code directly in the email (not a link)



