# Final Email Verification Setup

## STEP 1: Disable Email Confirmation (For Testing Now)

1. Go to: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/settings
2. Find **"Enable email confirmations"**
3. Turn it **OFF**
4. Click **"Save"**

**Result:** Users can sign up and sign in immediately. No verification needed.

---

## STEP 2: When Ready for Production (Later)

### A. Enable Email Confirmation
1. Go to: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/settings
2. Turn **"Enable email confirmations"** **ON**
3. Save

### B. Update Email Template
1. Go to: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/templates/confirm-sign-up
2. **Subject:** `Confirm Your Signup - Code: {{ .Token }}`
3. **Body (HTML):**
```html
<h2>Confirm your signup</h2>
<p>Your verification code is:</p>
<h1 style="font-size: 36px; letter-spacing: 10px; text-align: center; color: #EF4444; font-weight: bold; margin: 20px 0;">{{ .Token }}</h1>
<p>Enter this code in the app to verify your email.</p>
<p>This code expires in 1 hour.</p>
```
4. Click **"Save changes"**

### C. The App Already Has OTP Support
The app code is already set up to:
- Send OTP codes via `sendOTP()`
- Verify codes via `verifyOTP()`
- Show the verification screen when needed

---

## For Now (Testing)

**Just disable email confirmation and test the app!**

The app will work immediately without any verification steps.



