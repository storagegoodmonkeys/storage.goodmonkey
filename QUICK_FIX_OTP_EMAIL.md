# Quick Fix: Get OTP Code from Email

## Current Problem
- Email contains link pointing to `localhost:3000`
- Link expired (`otp_expired`)
- Need code, not link

## Fix in Supabase Dashboard

### Step 1: Fix Site URL & Redirect URLs

1. **Go to URL Configuration:**
   https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/url-configuration

2. **Change Site URL:**
   - Current: `http://localhost:3000` ❌
   - Change to: `https://kjhhwrvduqxprweqxhbo.supabase.co` ✅
   - Or: Leave blank for iOS app
   - Click **"Save"**

3. **Remove localhost from Redirect URLs:**
   - Remove any `http://localhost:*` entries
   - Click **"Save"**

### Step 2: Update Email Template to Show Code

1. **Go to Email Templates:**
   https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/templates

2. **Click "Confirm signup" template**

3. **Update Subject:**
   ```
   Confirm your signup - Code: {{ .Token }}
   ```

4. **Update Body (HTML):**
   ```html
   <h2>Confirm your signup</h2>
   <p>Your verification code is:</p>
   <h1 style="font-size: 36px; letter-spacing: 8px; text-align: center; color: #EF4444;">{{ .Token }}</h1>
   <p>Enter this code in the app to verify your email.</p>
   <p>This code expires in 1 hour.</p>
   ```

5. **Update Body (Plain Text):**
   ```
   Confirm your signup
   
   Your verification code is: {{ .Token }}
   
   Enter this code in the app to verify your email.
   This code expires in 1 hour.
   ```

6. **Click "Save"**

### Step 3: Test Again

1. Sign up with a new email (or wait a bit and try again)
2. Check email - should now show the CODE directly
3. Enter code in app

## Alternative: Extract Code from Link (If Still Getting Links)

If Supabase still sends links, the token is in the URL. But since it expired, you need a fresh one.

**After fixing redirect URL and template:**
1. Sign up again
2. Get fresh email
3. If it's a link, the token is after `token=` in the URL
4. Use that token as your verification code

## That's It!

After these changes:
- ✅ No more localhost redirects
- ✅ Code shown directly in email
- ✅ Can verify in app easily



