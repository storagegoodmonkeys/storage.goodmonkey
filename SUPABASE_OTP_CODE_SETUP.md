# 📧 How to Get OTP Code Instead of Link in Supabase

## Current Issue
Supabase is sending a **confirmation link** instead of an **OTP code** in the email.

## Solution: Configure Supabase Email Template

### Step 1: Go to Supabase Email Templates

1. **Go to Supabase Dashboard:**
   https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/templates

2. **Find "Confirm signup" template**

### Step 2: Update Email Template

The template should include the OTP code. Here's what you need to change:

**Current Template (Link-based):**
```
Confirm your signup
Follow this link to confirm your user:
{{ .ConfirmationURL }}
```

**New Template (Code-based):**
```
Confirm your signup
Your verification code is: {{ .Token }}
Enter this code in the app to verify your email.
```

### Step 3: Alternative - Use Magic Link with Token Extraction

If Supabase doesn't support `{{ .Token }}` directly, you can:

1. **Check the email subject or body** - The code might be in the confirmation URL
2. **Or use the link** - Extract the token from the URL and use it

## Quick Fix: Extract Code from Link

If Supabase sends a link, the token is usually in the URL. Here's how to find it:

1. **Click the confirmation link** in the email
2. **Look at the URL** - it will have a token like:
   ```
   https://kjhhwrvduqxprweqxhbo.supabase.co/auth/v1/verify?token=ABC123XYZ&type=signup
   ```
3. **The code is the `token` parameter** (ABC123XYZ in this example)

## Better Solution: Configure Custom Email Template

### In Supabase Dashboard:

1. Go to: **Authentication** → **Email Templates**
2. Click on **"Confirm signup"** template
3. Update the template to:

```html
<h2>Confirm your signup</h2>
<p>Your verification code is:</p>
<h1 style="font-size: 32px; letter-spacing: 8px; text-align: center;">{{ .Token }}</h1>
<p>Enter this 6-digit code in the app to verify your email.</p>
<p>This code will expire in 1 hour.</p>
```

**Note:** The exact template variable might be different. Common variables:
- `{{ .Token }}`
- `{{ .ConfirmationCode }}`
- `{{ .Code }}`
- `{{ .OTP }}`

## Test It

1. Sign up again with a test email
2. Check your inbox
3. You should see the code directly in the email

## If Still Getting Links

If Supabase still sends links, you can:
1. Use the link (it will verify)
2. Or manually extract the token from the URL
3. Or configure Supabase to use OTP mode properly

Let me know what you see in the email and I can help you configure it!



