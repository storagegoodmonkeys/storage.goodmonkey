# Correct Supabase Setup for OTP Verification

## Important: You Don't Need Redirect URLs for OTP!

Since we're using **code-based verification** (OTP), users enter the code directly in the app. No redirect URLs needed!

## What You Actually Need to Configure

### 1. Site URL (Optional - for future use)
- Location: URL Configuration → Site URL
- Set to: `https://kjhhwrvduqxprweqxhbo.supabase.co`
- This is mainly for web apps, but won't hurt to set it

### 2. Redirect URLs (Can Leave Empty or Remove localhost)
- Location: URL Configuration → Redirect URLs
- Remove any `localhost:3000` entries
- You can leave this empty or add your project URL if needed

### 3. Email Template (CRITICAL - This is what you need!)
- Location: Authentication → Email → "Confirm sign up" template
- **Subject:** `Confirm Your Signup - Code: {{ .Token }}`
- **Body:**
```html
<h2>Confirm your signup</h2>
<p>Your verification code is:</p>
<h1 style="font-size: 36px; letter-spacing: 10px; text-align: center; color: #EF4444; font-weight: bold; margin: 20px 0;">{{ .Token }}</h1>
<p>Enter this code in the app to verify your email.</p>
<p>This code will expire in 1 hour.</p>
```

### 4. Email Confirmation Settings
- Location: Authentication → Settings
- Make sure "Enable email confirmations" is **ON**

## About the "requested path is invalid" Error

This error might appear if:
1. You're trying to add an invalid URL format
2. The URL contains special characters
3. There's a trailing slash issue

**Solution:** Just skip the redirect URL configuration for now. It's not needed for OTP verification!

## Testing

1. Update the email template (Step 3 above)
2. Save changes
3. Sign up with a new email
4. Check your inbox - you should see the code directly in the email
5. Enter the code in the app

That's it! No redirect URLs needed.



