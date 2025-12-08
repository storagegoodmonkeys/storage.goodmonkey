# Fix OTP Email Link Issue

## Problem
- Email contains a link pointing to `localhost:3000` 
- Link expired (`otp_expired` error)
- Need to get code directly, not a link

## Solution 1: Fix Redirect URL in Supabase

### Step 1: Configure Redirect URLs
1. Go to: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/url-configuration
2. In **"Redirect URLs"**, add:
   ```
   flick://auth/callback
   ```
   Or your app's URL scheme
3. **Remove** any `localhost` URLs
4. Click **"Save"**

### Step 2: Update Email Template
1. Go to: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/templates
2. Click **"Confirm signup"** template
3. Replace the link with the code display:

**Template:**
```
Your verification code is: {{ .Token }}

Enter this code in the app.
```

## Solution 2: Use OTP Endpoint Correctly

The OTP endpoint should send a code, not a link. Make sure:
- Using `/auth/v1/otp` endpoint (we are ✅)
- Email template shows the code (needs configuration)
- No redirect URL configured for OTP (removes the link)

## Quick Test
After fixing:
1. Sign up again
2. Check email - should show code directly
3. Enter code in app



