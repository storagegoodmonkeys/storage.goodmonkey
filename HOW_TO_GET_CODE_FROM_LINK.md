# How to Get Code from Supabase Email Link

## Current Situation
You're receiving an email with a **link** instead of a **code**. Here's how to fix it:

## Option 1: Extract Token from Link (Quick Solution)

When you click the link, the URL will look like:
```
https://kjhhwrvduqxprweqxhbo.supabase.co/auth/v1/verify?token=ABC123XYZ456&type=signup
```

The **token** (code) is the part after `token=`. You can:
1. Click the link and copy the token from the URL
2. Use that token in the app as the verification code

But this is not ideal - we want the code directly in the email!

## Option 2: Configure Email Template to Show Code (Recommended)

### Step 1: Go to Email Templates

1. Go to: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/templates

### Step 2: Edit "Confirm signup" Template

Click on **"Confirm signup"** template and update it to:

**Subject:** `Confirm your signup - Your code is {{ .Token }}`

**Body (HTML):**
```html
<h2>Confirm your signup</h2>
<p>Your verification code is:</p>
<h1 style="font-size: 36px; letter-spacing: 10px; text-align: center; color: #EF4444; font-weight: bold;">{{ .Token }}</h1>
<p>Enter this code in the app to verify your email.</p>
<p>This code will expire in 1 hour.</p>
<p>If you didn't request this, you can ignore this email.</p>
```

**Body (Plain Text):**
```
Confirm your signup

Your verification code is: {{ .Token }}

Enter this code in the app to verify your email.
This code will expire in 1 hour.

If you didn't request this, you can ignore this email.
```

### Step 3: Save Template

Click **"Save"** at the bottom of the template editor.

## Option 3: Alternative Template Variables

If `{{ .Token }}` doesn't work, try these variables:
- `{{ .ConfirmationCode }}`
- `{{ .Code }}`
- `{{ .OTP }}`
- `{{ .VerificationCode }}`

## What You Should See After Update

After updating the template, when you sign up:
- Email subject: "Confirm your signup - Your code is 123456"
- Email body: Shows the code in large, bold text
- Code is easy to copy/paste into the app

## Test It

1. Update the email template in Supabase
2. Sign up with a test email
3. Check the email - you should see the code!
4. Enter the code in the app

## If Template Variables Don't Work

If Supabase doesn't support `{{ .Token }}` in templates, we can:
1. Modify the app to handle the link click
2. Extract the token from the URL automatically
3. Or use a different verification method

Let me know what happens after you update the template!



