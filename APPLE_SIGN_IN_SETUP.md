# Apple Sign In Setup Guide

## Current Implementation Status

The current Apple Sign In uses a **workaround approach** that creates regular email/password accounts for Apple users. This works but is not the ideal solution.

## Why It's Not Working Properly

1. **Missing OAuth Configuration**: Proper Apple Sign In requires OAuth setup in Supabase
2. **Email Availability**: Apple only provides email on first sign-in
3. **No Proper Token Exchange**: Not using Supabase's OAuth endpoints

## Current Workaround (What's Implemented)

The app now:
- ✅ Handles Apple Sign In flow
- ✅ Stores Apple User ID for identification
- ✅ Saves email/username on first sign-in
- ✅ Creates Supabase accounts for Apple users
- ✅ Falls back to local user if Supabase fails

## To Fix Properly (For Production)

### Step 1: Configure Apple Developer Account

1. **Go to Apple Developer Portal**: https://developer.apple.com/account/
2. **Create App ID** (if not exists):
   - Certificates, Identifiers & Profiles → Identifiers
   - Click "+" → App IDs
   - Enable "Sign In with Apple" capability
   - Register with Bundle ID: `FLICK.Flick-app-IOS`

3. **Create Service ID**:
   - Go to Identifiers → Services IDs
   - Click "+" to create new Service ID
   - Enable "Sign In with Apple"
   - Configure domains and redirect URLs:
     - **Primary App ID**: Your App ID
     - **Domains**: `kjhhwrvduqxprweqxhbo.supabase.co`
     - **Return URLs**: `https://kjhhwrvduqxprweqxhbo.supabase.co/auth/v1/callback`

4. **Create Key**:
   - Go to Keys → Click "+"
   - Enable "Sign In with Apple"
   - Download the key (.p8 file) - **Save this!**
   - Note the Key ID

5. **Note your Team ID**:
   - Found in top right of Apple Developer Portal

### Step 2: Configure Supabase

1. **Go to Supabase Dashboard**: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/providers

2. **Enable Apple Provider**:
   - Find "Apple" in the providers list
   - Click to enable and configure:
     - **Client ID**: Your Service ID (created above)
     - **Secret Key**: Contents of the .p8 file you downloaded
     - **Team ID**: Your Apple Developer Team ID
     - **Key ID**: The Key ID from step above

3. **Save Configuration**

### Step 3: Update iOS App Code

Once Supabase OAuth is configured, update the app to use proper OAuth flow:

```swift
// This would replace the current workaround
func signInWithApple() {
    // Get OAuth URL from Supabase
    let oauthURL = "\(supabaseURL)/auth/v1/authorize?provider=apple"
    // Open URL, handle callback
}
```

## Quick Fix for Testing (Current Implementation)

The current code will work for testing but has limitations:
- Creates email/password accounts for Apple users
- May fail if email verification is enabled
- Not using proper OAuth tokens

**To test now:**
1. Make sure email confirmation is **disabled** in Supabase (for testing)
2. Try Apple Sign In - it should create a user account
3. On subsequent sign-ins, it will try to sign in with stored credentials

## Troubleshooting

### "Sign in with Apple failed"
- Check if Sign In with Apple capability is enabled in Xcode
- Verify App ID has Sign In with Apple enabled in Apple Developer Portal

### "User canceled Apple Sign In"
- This is normal - user chose not to sign in

### "Supabase sign up failed"
- Check if email confirmation is disabled (for testing)
- Verify Supabase connection
- Check Xcode console for detailed error messages

## Production Checklist

Before going to production:
- [ ] Configure proper Apple OAuth in Supabase
- [ ] Test OAuth flow end-to-end
- [ ] Re-enable email confirmation
- [ ] Remove workaround code
- [ ] Implement proper OAuth token handling
- [ ] Test on real device
- [ ] Test with TestFlight

## Current Supabase Project

- **URL**: https://kjhhwrvduqxprweqxhbo.supabase.co
- **Dashboard**: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo

