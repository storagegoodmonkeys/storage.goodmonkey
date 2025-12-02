# Flick App - Lighter Tracking iOS Application

A modern iOS app built with SwiftUI for tracking, trading, and collecting unique lighters.

## 🚀 Features

- **Lighter Collection Management** - Register and track your lighters with QR codes
- **Marketplace** - Trade lighters with other collectors
- **Lost & Found** - Report and find lost lighters
- **Achievements** - Earn badges for collecting milestones
- **Social Features** - Leaderboard and user profiles

## 🛠️ Tech Stack

- **Frontend**: SwiftUI
- **Backend**: Supabase (PostgreSQL + REST API)
- **Authentication**: Supabase Auth (Email, Google, Apple Sign In)
- **Database**: PostgreSQL with Row Level Security

## 📋 Setup

### Prerequisites

- Xcode 15.0+
- iOS 18.5+
- Supabase account

### Installation

1. Clone the repository:
```bash
git clone https://github.com/storagegoodmonkeys/storage.goodmonkey.git
cd storage.goodmonkey
```

2. Open in Xcode:
```bash
open "flick-ios/Flick app IOS/Flick app IOS.xcodeproj"
```

3. Add Supabase Swift SDK:
   - File → Add Package Dependencies
   - URL: `https://github.com/supabase/supabase-swift`
   - Version: 2.0.0+

4. Configure Supabase:
   - Get credentials from: https://supabase.com/dashboard/project/YOUR_PROJECT/settings/api
   - Update `SupabaseService.swift` with your URL and key
   - Run `supabase_schema.sql` in Supabase SQL Editor

### Database Setup

1. Go to Supabase SQL Editor
2. Run the SQL from `supabase_schema.sql`
3. Verify tables are created in Table Editor

## 📁 Project Structure

```
flick-ios/
├── Flick app IOS/
│   ├── Flick app IOS/
│   │   ├── Models/          # Data models
│   │   ├── Views/           # SwiftUI views
│   │   ├── Services/        # Backend services
│   │   ├── Theme/           # App theming
│   │   └── Utils/           # Utilities & mock data
```

## 🔐 Environment Variables

Update these in `SupabaseService.swift`:
- `supabaseURL`: Your Supabase project URL
- `supabaseKey`: Your Supabase anon/public key

## 📱 Features in Detail

- **Onboarding**: Welcome screens with app introduction
- **Authentication**: Sign up, sign in, Apple Sign In
- **Home**: Latest lighters, campaigns, top collections
- **Collection**: User's lighter vault with grid view
- **Marketplace**: Browse and trade lighters
- **Lost & Found**: Report and search for lost lighters
- **Profile**: User stats, achievements, settings

## 🗄️ Database Schema

- `users` - User profiles
- `lighters` - Lighter collection
- `achievements` - User achievements
- `trades` - Trade requests
- `lost_found` - Lost/found reports
- `ownership_history` - Ownership tracking

See `supabase_schema.sql` for complete schema.

## 🚀 Deployment

1. Build for production in Xcode
2. Test on device/simulator
3. Archive and upload to App Store Connect

## 📝 License

Proprietary - Client Work

## 👥 Team

CodeFlow Studios

