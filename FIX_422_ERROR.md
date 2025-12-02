# Fix for 422 Error on Sign Up

## 🔍 Issue:
HTTP 422 error when creating account means "Unprocessable Entity" - usually because:
1. **Email confirmation is enabled** in Supabase (most common)
2. Request format issue
3. Validation error

## ✅ Solution:

### Option 1: Disable Email Confirmation (Recommended for Development)

1. Go to Supabase Dashboard: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/auth/providers
2. Click **Settings** → **Auth**
3. Scroll to **"Enable email confirmations"**
4. **Toggle OFF** email confirmations
5. Save changes

### Option 2: Handle Email Confirmation in App

The code has been updated to handle both cases:
- If email confirmation is disabled → User is signed in immediately
- If email confirmation is enabled → User object is returned but needs to confirm email

---

## 🧪 Test Again:

After disabling email confirmation:
1. Build and run the app
2. Try signing up again
3. Should work without 422 error

---

## 📝 Alternative: Check Error Message

If you want to see the exact error, check Xcode console logs - the updated code now prints detailed error messages.

