# Backend Integration Guide

## 📋 Checklist

### ✅ Completed
- [x] Database schema created (`supabase_schema.sql`)
- [x] SupabaseService created with all CRUD operations
- [x] AuthenticationManager updated to use SupabaseService
- [x] Setup documentation created

### 🔄 Next Steps

## Step 1: Run SQL Schema in Supabase

1. Go to: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/sql
2. Copy contents of `supabase_schema.sql`
3. Paste and run in SQL Editor
4. Verify tables are created in Table Editor

## Step 2: Get Supabase Credentials

1. Go to: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/settings/api
2. Copy:
   - **Project URL**: `https://kjhhwrvduqxprweqxhbo.supabase.co`
   - **anon/public key**: (long string)

## Step 3: Add Supabase SDK to Xcode

1. In Xcode: **File → Add Package Dependencies**
2. Enter URL: `https://github.com/supabase/supabase-swift`
3. Select version: `2.0.0` or latest
4. Add to target: `Flick app IOS`

## Step 4: Update SupabaseService.swift

1. Open `SupabaseService.swift`
2. Replace:
   ```swift
   private let supabaseURL = "YOUR_SUPABASE_URL"
   private let supabaseKey = "YOUR_SUPABASE_ANON_KEY"
   ```
3. With your actual credentials

## Step 5: Uncomment Supabase Code

After adding the SDK, uncomment the actual Supabase implementation in `SupabaseService.swift` and remove the mock fallbacks.

## Step 6: Test Integration

1. Build and run the app
2. Test sign up flow
3. Check Supabase Dashboard → Authentication → Users
4. Test adding a lighter
5. Check Supabase Dashboard → Table Editor → lighters

## Database Schema Overview

### Tables
- **users** - User profiles and authentication
- **lighters** - User's lighter collection
- **achievements** - User achievements/badges
- **trades** - Trade requests between users
- **lost_found** - Lost and found reports
- **ownership_history** - Track lighter ownership changes

### Views
- **marketplace_lighters** - Lighters available for trade
- **user_stats** - User statistics aggregations

### Security
- ✅ Row Level Security (RLS) enabled
- ✅ Policies restrict data access appropriately
- ✅ Users can only modify their own data
- ✅ Public read access for marketplace and lost/found

## API Endpoints Available

All operations go through `SupabaseService`:

- `signUp()` - Create new user
- `signIn()` - Authenticate user
- `signOut()` - Sign out user
- `getUserProfile()` - Get user data
- `updateUserProfile()` - Update user profile
- `getLighters()` - Get user's lighters
- `addLighter()` - Register new lighter
- `updateLighter()` - Update lighter details
- `deleteLighter()` - Remove lighter
- `getMarketplaceLighters()` - Get tradeable lighters
- `createTrade()` - Create trade request
- `updateTradeStatus()` - Accept/reject trades
- `getAchievements()` - Get user achievements
- `reportLostFound()` - Report lost/found lighter
- `getLostFound()` - Get lost/found reports

## Troubleshooting

### "Supabase client not initialized"
- Check that you've added the Supabase SDK package
- Verify credentials are set correctly

### "Authentication failed"
- Check Supabase Dashboard → Authentication → Settings
- Verify email authentication is enabled
- Check RLS policies are correct

### "Permission denied"
- Check RLS policies in Supabase
- Verify user is authenticated
- Check table permissions

## Support

For issues:
1. Check Supabase Dashboard logs
2. Check Xcode console for errors
3. Verify SQL schema ran successfully
4. Check RLS policies match your needs

