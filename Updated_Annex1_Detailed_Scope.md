# ANNEX 1 - UPDATED
## Detailed Scope of Work
### Flick MVP - iOS Application Development
**October 8, 2025**

---

## 1. Introduction

This document provides a comprehensive breakdown of all features, modules, and functionalities to be developed as part of the Flick MVP (Minimum Viable Product) for iOS platform, **including all additional features requested by Good Monkeys LLC**. This annex forms an integral part of the Application Development Agreement between Good Monkeys LLC and CodeFlow Studios.

## 1.1 Project Scope

**Platform:** iOS (iPhone and iPad compatible)  
**Development Framework:** Flutter or React Native (cross-platform capable, optimized for iOS)  
**Backend:** Node.js with Express.js framework  
**Database:** Supabase or Firebase (cloud-hosted, scalable)  
**Cloud Infrastructure:** AWS, Vercel, or Google Cloud Platform  
**Note:** Android development is excluded from this MVP scope. Focus is exclusively on iOS platform delivery.

---

## 2. Core Modules & Features

### 2.1 Enhanced QR Code Scanning & Lighter Registration

**Purpose:** Enable users to scan QR codes using native iOS camera and provide comprehensive web-based fallback system.

**Features:**
- **Native iOS Camera Integration:** Users can scan QR codes directly using their phone's native camera app
- **Deep Linking:** If app is installed, QR scan opens app directly to relevant screen
- **Web Fallback System:** If app not installed, QR opens web page with notification-style interface
- **Smart Routing Logic:**
  - Registered lighter: "This lighter is registered to a user — it might be lost. Do you want to return it or claim it?"
  - Unregistered lighter: "This is a brand-new lighter — add it to your collection!" with app download link
- **In-App QR Scanner:** Available for registered users within the app
- **Unique lighter ID generation and validation**
- **Photo capture functionality to document the lighter**
- **Duplicate detection to prevent multiple registrations**
- **Registration confirmation with success notification**
- **History log of all scanned/registered lighters**

### 2.2 User Profiles & Onboarding

**Purpose:** Create personalized user accounts with profile management and seamless onboarding.

**Features:**
- User registration with email or social OAuth (Google Sign-In)
- Profile creation with username, avatar, bio, and location
- Email verification and password recovery
- Onboarding tutorial (first-time user walkthrough)
- Profile editing and customization
- **Privacy settings (public/private profile)**
- View personal lighter collection
- Activity feed showing recent scans, trades, and achievements
- Push notification preferences

### 2.3 Ownership History Tracking

**Purpose:** Allow users to view the ownership chain of lighters while respecting privacy preferences.

**Features:**
- **Ownership chain tracking in database schema**
- **Privacy-respecting display (only public profiles shown)**
- **Clean timeline view: "X → A → B → You"**
- **Optional privacy settings for each user**
- **Integration with existing trade/lost & found workflows**
- View previous owners' publicly shared details (name, profile photo, optional info)
- Privacy controls to remain anonymous in ownership history
- Ownership transfer logging and history

### 2.4 Smart Location Update System

**Purpose:** Proactively track lighter locations through user-friendly notifications.

**Features:**
- **Smart push notifications asking "Is your lighter with you?"**
- **One-tap responses (Yes/No)**
- **Automatic location updates when user confirms**
- **Follow-up "Is it lost?" flow for missing lighters**
- **Non-intrusive frequency (max 1-2 prompts per week)**
- **Respects user privacy and battery life**
- Location-based lighter tracking
- Optional manual location updates
- Location history for lost & found purposes

### 2.5 Lost & Found Workflow

**Purpose:** Allow users to report lost lighters and facilitate their recovery through community engagement.

**Features:**
- Report a lighter as 'Lost' with description and location
- Browse lost lighters in the community
- Mark a lighter as 'Found' when scanned by another user
- Notification system to alert original owner when lighter is found
- In-app messaging to coordinate lighter return
- Optional reward system (user can offer reward for return)
- Lost & Found history tracking
- Map view showing locations of reported lost lighters
- Integration with smart location update system

### 2.6 Trading and Gifting Features

**Purpose:** Enable peer-to-peer lighter exchanges and gifts within the community.

**Features:**
- Browse available lighters for trade in community marketplace
- Send trade requests to other users
- Accept/reject trade offers with messaging
- Gift lighters to friends or community members
- Transfer ownership through secure transaction
- Trade history and transaction log
- Rating system for successful trades
- Search and filter lighters by brand, rarity, or design
- Wishlist functionality to track desired lighters
- Integration with ownership history tracking

### 2.7 Basic Gamification and Rewards (Lite Version)

**Purpose:** Encourage user engagement through achievements, points, and leaderboards.

**Features:**
- Point system for various activities (scans, trades, referrals, location updates)
- Achievement badges (e.g., 'First Scan', 'Collector', 'Trader', 'Helper', 'Location Tracker')
- Leaderboard showing top collectors and active users
- Level progression system (Bronze, Silver, Gold, Platinum tiers)
- Daily login rewards
- Referral bonus program
- Milestone celebrations (e.g., 10th lighter scanned)
- Exclusive digital collectibles for top users
- Social sharing of achievements

### 2.8 Admin Dashboard

**Purpose:** Provide administrators with tools to manage the platform, users, and content.

**Features:**
- Web-based admin panel (accessible via browser)
- User management (view, edit, suspend, delete accounts)
- Lighter database management (view all registered lighters)
- Analytics dashboard (user growth, activity metrics, engagement rates)
- Content moderation tools (review flagged content, messages)
- Push notification broadcast system
- Report management (handle user reports and disputes)
- System configuration and settings
- Export data (CSV/Excel reports for analytics)
- Ownership history management
- Location tracking analytics

### 2.9 Backend APIs and Cloud Integration

**Purpose:** Build robust, scalable backend infrastructure to support all app functionalities.

**Features:**
- RESTful API endpoints for all app features
- User authentication API (OAuth, JWT tokens)
- QR code validation and lighter registration API
- Real-time messaging API for trades and lost & found
- Push notification service integration (Firebase Cloud Messaging)
- Cloud storage for user photos and lighter images
- Database schema design and implementation
- API rate limiting and security measures
- Error handling and logging system
- Automated backup and data recovery system
- **Social-ready architecture for future feed features**
- **Event logging system for activity tracking**
- **Scalable infrastructure for future expansion**

### 2.10 Mobile App (iOS)

**Purpose:** Develop native-quality iOS application with intuitive UI/UX.

**Features:**
- iOS-optimized user interface (iPhone 12 and above)
- iPad compatibility with responsive design
- Native iOS design patterns and gestures
- Smooth animations and transitions
- Offline mode for viewing personal collection
- Dark mode support
- In-app camera integration for QR scanning
- Location services integration (for lost & found features)
- Push notifications
- App Store deployment and optimization
- TestFlight beta testing setup
- **Deep linking support for QR code scanning**
- **Native camera integration for QR scanning**

### 2.11 Landing Website for goodmonkeys.com

**Purpose:** Single-page marketing website (complimentary deliverable).

**Features:**
- **Company Section: About Good Monkeys LLC, mission, team**
- **Flick App Section: App introduction, features showcase, download buttons**
- **Contact Form: Professional contact system with email forwarding**
- **Responsive Design: Mobile-optimized for all devices**
- **SEO Optimized: Ready for search engine visibility**
- **Integrated Experience: Seamless flow between company info and app promotion**
- Hero section with app overview and download link
- Feature highlights section
- Screenshots gallery (carousel)
- Call-to-action buttons (Download from App Store)
- Social media links
- Fast loading and SEO optimization
- Hosting on Vercel or Netlify (included)

---

## 3. Technical Specifications

### 3.1 Technology Stack

| Component | Technology |
|-----------|------------|
| Mobile Framework | Flutter or React Native |
| Target Platform | iOS (iPhone & iPad) |
| Backend Framework | Node.js + Express.js |
| Database | Supabase or Firebase |
| Authentication | OAuth 2.0 (Google) + Email/Password |
| Cloud Infrastructure | AWS / GCP / Vercel |
| Push Notifications | Firebase Cloud Messaging (FCM) |
| File Storage | AWS S3 or Firebase Storage |
| Version Control | GitHub |

### 3.2 Database Schema (Enhanced)

**Core Tables:**
- **users:** user_id, email, username, avatar_url, created_at, points, level, privacy_settings
- **lighters:** lighter_id, qr_code, owner_id, brand, color, photo_url, status, registered_at, location_history
- **trades:** trade_id, requester_id, owner_id, lighter_offered_id, lighter_requested_id, status, created_at
- **lost_found:** report_id, lighter_id, reporter_id, status, description, last_location, reported_at
- **messages:** message_id, sender_id, recipient_id, content, timestamp, read_status
- **achievements:** achievement_id, user_id, badge_type, earned_at
- **notifications:** notification_id, user_id, type, content, read_status, created_at
- **ownership_history:** history_id, lighter_id, previous_owner_id, new_owner_id, transfer_date, transfer_type
- **location_updates:** location_id, lighter_id, user_id, latitude, longitude, timestamp, is_lost
- **qr_web_sessions:** session_id, qr_code, user_agent, ip_address, action_taken, timestamp

---

## 4. Project Deliverables

### iOS Application
- Production-ready app submitted to Apple App Store
- TestFlight build for beta testing
- Complete source code repository

### Backend Infrastructure
- Deployed and configured cloud backend
- API documentation (Swagger/Postman collection)
- Database schema documentation

### Admin Dashboard
- Web-based admin panel (deployed and accessible)
- Admin user manual and documentation

### Landing Website
- Single-page website for goodmonkeys.com
- Deployed and live on production server

### Documentation
- Technical documentation (architecture, API specs)
- User manual and onboarding guide
- Deployment and maintenance guide

---

## 5. Exclusions from Scope

- Android application development (excluded from MVP)
- Advanced AI/ML features (e.g., lighter image recognition)
- Payment gateway integration (no monetization in MVP)
- Third-party brand partnerships or integrations
- Advanced analytics and business intelligence tools
- Multi-language support (English only for MVP)
- Video content or streaming features
- **Advanced social media integration (basic social features included)**

---

## 6. Testing & Quality Assurance

### 6.1 Testing Approach
- Unit testing for backend APIs and critical functions
- Integration testing for end-to-end workflows
- iOS device testing (iPhone 12, 13, 14 series)
- iPad compatibility testing
- Performance testing (load times, API response times)
- Security testing (authentication, data protection)
- User acceptance testing (UAT) with Good Monkeys LLC team
- Beta testing via TestFlight with selected users
- **QR code scanning testing across different devices**
- **Web fallback system testing**

---

## 7. Post-Launch Support (3 Months)

- Bug fixes and critical issue resolution
- Security patches and updates
- Performance monitoring and optimization
- Minor UI/UX improvements based on user feedback
- iOS version updates (compatibility with latest iOS releases)
- Cloud infrastructure monitoring and maintenance
- Monthly progress reports and analytics review
- **QR web system maintenance and updates**
- **Location tracking system optimization**

---

**This document forms Annex 1 of the Application Development Agreement between Good Monkeys LLC and CodeFlow Studios, dated October 8, 2025.**



