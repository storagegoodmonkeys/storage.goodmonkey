# Supabase Setup Guide for Flick App

## Step 1: Get Supabase Credentials

1. Go to your Supabase project: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/settings/api
2. Copy the following:
   - **Project URL** (looks like: `https://kjhhwrvduqxprweqxhbo.supabase.co`)
   - **anon/public key** (long string starting with `eyJ...`)

## Step 2: Create Database Schema

1. Go to SQL Editor in Supabase: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/sql
2. Click "New query"
3. Copy and paste the entire contents of `supabase_schema.sql`
4. Click "Run" to execute the SQL
5. Verify tables were created by going to Table Editor

## Step 3: Configure iOS App

1. Open `SupabaseService.swift`
2. Replace `YOUR_SUPABASE_URL` with your Project URL
3. Replace `YOUR_SUPABASE_ANON_KEY` with your anon key

```swift
private let supabaseURL = "https://kjhhwrvduqxprweqxhbo.supabase.co"
private let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." // Your actual key
```

## Step 4: Add Supabase iOS SDK

Add to your `Package.swift` or via Xcode:

```swift
dependencies: [
    .package(url: "https://github.com/supabase/supabase-swift", from: "2.0.0")
]
```

Or add via Xcode:
1. File → Add Package Dependencies
2. Enter: `https://github.com/supabase/supabase-swift`
3. Select version 2.0.0 or later

## Step 5: Verify Setup

1. Build the app
2. Test authentication flow
3. Check Supabase Dashboard → Authentication → Users to see created users

## Database Tables Created

- ✅ `users` - User profiles
- ✅ `lighters` - Lighter collection
- ✅ `achievements` - User achievements
- ✅ `trades` - Trade requests
- ✅ `lost_found` - Lost and found reports
- ✅ `ownership_history` - Lighter ownership tracking

## Security Features

- ✅ Row Level Security (RLS) enabled on all tables
- ✅ Policies restrict access to user's own data
- ✅ Public read access where appropriate (marketplace, lost/found)
- ✅ Automatic user profile creation on signup

## Next Steps

1. Update `AuthenticationManager` to use `SupabaseService`
2. Replace mock data with real API calls
3. Test all CRUD operations
4. Add image upload to Supabase Storage for lighter photos

