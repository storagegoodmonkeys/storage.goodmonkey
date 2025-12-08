# Fix "requested path is invalid" Error

## Where Are You Seeing This Error?

### Scenario 1: In Supabase Dashboard (URL Configuration)
**Solution:** Just skip it! You don't need redirect URLs for OTP verification.

**Steps:**
1. Don't worry about the redirect URL error
2. Close that page/tab
3. Go directly to: **Authentication → Email → "Confirm sign up"**
4. Update the email template (see below)
5. Save changes

### Scenario 2: In the App (When Signing Up)
**This means the OTP endpoint might have issues.**

**Possible Fixes:**

#### Fix 1: Check Email Confirmation Settings
1. Go to: **Authentication → Settings**
2. Make sure **"Enable email confirmations"** is **ON**
3. Save

#### Fix 2: Try Using signup Endpoint Instead
The app might need to use the regular signup endpoint instead of OTP. But first, let's try Fix 3.

#### Fix 3: Update Email Template First
The error might be because the email template isn't configured correctly.

**Update Email Template:**
1. Go to: **Authentication → Email → "Confirm sign up"**
2. **Subject:** `Confirm Your Signup - Code: {{ .Token }}`
3. **Body:** Replace with:
```html
<h2>Confirm your signup</h2>
<p>Your verification code is:</p>
<h1 style="font-size: 36px; letter-spacing: 10px; text-align: center; color: #EF4444; font-weight: bold; margin: 20px 0;">{{ .Token }}</h1>
<p>Enter this code in the app to verify your email.</p>
<p>This code will expire in 1 hour.</p>
```
4. **Save changes**

#### Fix 4: Temporary Workaround - Use Signup Instead of OTP
If OTP keeps failing, we can modify the app to use the regular signup endpoint. Let me know if you want this.

## What to Do Right Now

1. **Ignore the redirect URL error** (not needed for OTP)
2. **Update the email template** as shown above
3. **Enable email confirmations** in Settings
4. **Test signup again**

If it still fails, tell me exactly:
- Where you see the error (dashboard or app)
- What you were doing when it appeared
- Any error messages in the app console



