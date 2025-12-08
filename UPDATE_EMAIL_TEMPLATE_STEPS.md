# Update Email Template to Show Code

## What You See Now
- Subject: "Confirm Your Signup"
- Body: Link with `{{ .ConfirmationURL }}`

## What to Change

### Step 1: Update Subject
In the "Subject" field, change to:
```
Confirm your signup - Code: {{ .Token }}
```

### Step 2: Update Body (HTML)
In the "Body" field, replace the HTML with:

```html
<h2>Confirm your signup</h2>
<p>Your verification code is:</p>
<h1 style="font-size: 36px; letter-spacing: 10px; text-align: center; color: #EF4444; font-weight: bold; margin: 20px 0;">{{ .Token }}</h1>
<p>Enter this code in the app to verify your email.</p>
<p>This code will expire in 1 hour.</p>
<p>If you didn't request this, you can ignore this email.</p>
```

### Step 3: Click "Save" (or "Update Template")
Look for a Save/Update button at the bottom of the page and click it.

## If {{ .Token }} Doesn't Work

Supabase might use different variable names. Try these in order:

1. `{{ .Token }}` ← Try this first
2. `{{ .Code }}`
3. `{{ .ConfirmationCode }}`
4. `{{ .OTP }}`

If none work, we can extract the code from the URL link instead.

## After Saving

1. Sign up again with a test email
2. Check your inbox
3. You should see the code directly in the email!



