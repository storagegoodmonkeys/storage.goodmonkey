# ANNEX 2 - UPDATED
## Application Flow Diagram
### Flick MVP - iOS Application
**October 8, 2025**

---

## 1. Overview

This document describes the overall application flow, user journeys, data interactions, and backend architecture for the Flick MVP iOS application, **including all additional features requested by Good Monkeys LLC**. It provides a comprehensive view of how different modules interact with each other and with the backend infrastructure.

---

## 2. System Architecture

### 2.1 Enhanced Architecture Overview

| Layer | Components | Technology |
|-------|------------|------------|
| Presentation Layer | iOS Application (iPhone & iPad) + Web QR Fallback | Flutter/React Native + HTML/CSS/JS |
| API Layer | RESTful API Gateway | Node.js + Express.js |
| Business Logic Layer | Authentication, QR Processing, Trading Logic, Gamification Engine, Location Tracking, Ownership History | Node.js |
| Data Layer | User DB, Lighter DB, Transaction DB, Ownership History DB, Location DB | Supabase/Firebase |
| Storage Layer | Images, Documents, Backups | AWS S3 / Firebase Storage |
| Infrastructure Layer | Cloud Hosting, Load Balancing, CDN for Web QR | AWS/GCP/Vercel |

---

## 3. Key User Journey Flows

### 3.1 Enhanced QR Code Scanning Flow

| Step | Action | System Response |
|------|--------|-----------------|
| 1 | User scans QR code using native iOS camera | Camera app detects QR and attempts to open app |
| 2A | If app installed: Deep link to app | App opens directly to relevant screen |
| 2B | If app not installed: Open web page | Web page loads with notification-style interface |
| 3 | System validates QR code format | Backend checks if QR exists in database |
| 4A | If registered lighter: Show ownership status | Display "This lighter is registered - return or claim?" |
| 4B | If unregistered lighter: Show registration prompt | Display "New lighter - add to collection!" with download link |
| 5 | User takes action (return/claim/register) | System processes action and updates database |
| 6 | Success confirmation displayed | User receives confirmation and next steps |

### 3.2 Enhanced User Registration & Onboarding Flow

| Step | Action | System Response |
|------|--------|-----------------|
| 1 | User downloads app from App Store | App launches with splash screen |
| 2 | User sees welcome screen | Display registration options (Email/Google OAuth) |
| 3 | User selects registration method | Navigate to respective auth flow |
| 4 | User provides credentials | Backend validates and creates account |
| 5 | Email verification sent (if email signup) | User verifies email via link |
| 6 | User completes profile (username, avatar, privacy settings) | Data stored in User DB |
| 7 | Onboarding tutorial displayed | User learns key features including QR scanning |
| 8 | User lands on home screen | Display personal collection (empty initially) |

### 3.3 Enhanced Lost & Found Workflow

| Step | Action | System Response |
|------|--------|-----------------|
| 1 | User reports lighter as lost | Opens "Report Lost" form with lighter details |
| 2 | User provides description & last known location | Data saved to Lost & Found DB |
| 3 | Lost lighter appears in community feed | Other users can see lost item listing |
| 4 | Another user finds and scans the lighter | System detects lighter is marked as lost |
| 5 | Finder sees "This lighter is lost" notification | Option to contact owner displayed |
| 6 | Finder initiates contact | In-app message sent to original owner |
| 7 | Owner and finder coordinate return | Chat system facilitates communication |
| 8 | Owner confirms return | Lighter marked as recovered, finder awarded points |
| 9 | **NEW:** Ownership history updated | Previous owner chain preserved |

### 3.4 Enhanced Trading Workflow

| Step | Action | System Response |
|------|--------|-----------------|
| 1 | User browses marketplace | Display available lighters for trade |
| 2 | User selects desired lighter | Show lighter details, owner profile, and ownership history |
| 3 | User sends trade request | Select lighter from own collection to offer |
| 4 | Trade request sent | Owner receives push notification |
| 5 | Owner reviews trade offer | Can accept, reject, or counter-offer |
| 6 | If accepted: trade initiated | Backend updates ownership records |
| 7 | Both users confirm trade completion | Ownership transferred in database |
| 8 | Trade recorded in history | Both users awarded trade points |
| 9 | **NEW:** Ownership history chain updated | New owner can view previous ownership chain |

### 3.5 NEW: Smart Location Update Flow

| Step | Action | System Response |
|------|--------|-----------------|
| 1 | System sends push notification | "Is your lighter with you right now?" |
| 2 | User responds Yes/No | One-tap response captured |
| 3A | If Yes: Location updated | Current GPS location saved to lighter record |
| 3B | If No: Follow-up question | "Is your lighter lost?" |
| 4A | If lost: Mark as lost | Lighter status updated, owner notified |
| 4B | If not lost: Normal status | "Just not with me right now" recorded |
| 5 | System logs interaction | Analytics updated, frequency tracking |

### 3.6 NEW: Ownership History Viewing Flow

| Step | Action | System Response |
|------|--------|-----------------|
| 1 | User views lighter details | Display current lighter information |
| 2 | User taps "View History" | Request ownership history from backend |
| 3 | System retrieves ownership chain | Query database for previous owners |
| 4 | Filter by privacy settings | Only show users with public profiles |
| 5 | Display ownership timeline | Show "X → A → B → You" format |
| 6 | User can view previous owner profiles | Display public profile information |

---

## 4. Data Flow Architecture

### 4.1 Enhanced Authentication & Authorization Flow
- User initiates login (Email/Google OAuth)
- iOS app sends credentials to API Gateway
- API validates credentials against User DB
- If valid: JWT token generated and returned
- iOS app stores JWT token securely (Keychain)
- All subsequent API calls include JWT token in header
- API validates token on each request
- Token expires after 24 hours, refresh required

### 4.2 Enhanced QR Code Validation & Registration Flow
- User scans QR code via iOS camera or web interface
- System extracts unique lighter ID from QR code
- App/web sends lighter ID to backend API for validation
- Backend checks if ID format is valid
- Backend queries Lighter DB to check registration status
- **NEW:** Check ownership history if registered
- If new: create new lighter record with user_id linkage
- Upload lighter photo to cloud storage (S3/Firebase)
- Update User DB to link lighter to user's collection
- **NEW:** Initialize ownership history record
- Return success response with lighter details to app

### 4.3 Enhanced Real-Time Messaging Flow
- User initiates chat (from lost & found or trade screen)
- App sends message via API to backend
- Backend stores message in Messages DB
- Backend sends push notification to recipient via FCM
- Recipient's app receives push notification
- Recipient opens chat, app fetches message history from API
- Real-time updates via WebSocket or polling (every 5 seconds)
- All messages encrypted in transit (HTTPS)

### 4.4 NEW: Location Update Data Flow
- System triggers location update notification (scheduled)
- Push notification sent to user via FCM
- User responds with Yes/No
- If Yes: GPS coordinates captured and sent to API
- Backend validates and stores location data
- Lighter record updated with new location
- Analytics logged for tracking purposes
- If No: Follow-up flow initiated

---

## 5. Enhanced Database Schema

### 5.1 Core Database Tables (Updated)

| Table Name | Key Fields | Purpose |
|------------|------------|---------|
| users | user_id, email, username, avatar_url, created_at, points, level, privacy_settings | Store user account information |
| lighters | lighter_id, qr_code, owner_id, brand, color, photo_url, status, registered_at, current_location | Store registered lighter data |
| trades | trade_id, requester_id, owner_id, lighter_offered_id, lighter_requested_id, status, created_at | Manage trade requests and history |
| lost_found | report_id, lighter_id, reporter_id, status, description, last_location, reported_at | Track lost and found lighters |
| messages | message_id, sender_id, recipient_id, content, timestamp, read_status | In-app messaging system |
| achievements | achievement_id, user_id, badge_type, earned_at | Store user achievements and badges |
| notifications | notification_id, user_id, type, content, read_status, created_at | Push notification records |
| **ownership_history** | **history_id, lighter_id, previous_owner_id, new_owner_id, transfer_date, transfer_type** | **Track ownership changes** |
| **location_updates** | **location_id, lighter_id, user_id, latitude, longitude, timestamp, is_lost** | **Store location tracking data** |
| **qr_web_sessions** | **session_id, qr_code, user_agent, ip_address, action_taken, timestamp** | **Track QR web interactions** |

---

## 6. Enhanced API Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| /api/auth/register | POST | User registration |
| /api/auth/login | POST | User login |
| /api/auth/oauth/google | POST | Google OAuth login |
| /api/lighters/register | POST | Register new lighter |
| /api/lighters/my-collection | GET | Fetch user's lighter collection |
| /api/lighters/marketplace | GET | Browse available lighters for trade |
| /api/lighters/qr/validate | POST | Validate QR code and return status |
| /api/lighters/qr/web/action | POST | Handle QR web actions (return/claim/register) |
| /api/trades/request | POST | Send trade request |
| /api/trades/respond | PUT | Accept/reject trade |
| /api/lost-found/report | POST | Report lighter as lost |
| /api/lost-found/list | GET | Get list of lost lighters |
| /api/messages/send | POST | Send message |
| /api/messages/conversation/:userId | GET | Fetch conversation history |
| /api/users/profile/:userId | GET | Get user profile |
| /api/users/leaderboard | GET | Fetch leaderboard |
| /api/notifications/send | POST | Send push notification |
| **/api/lighters/:id/ownership-history** | **GET** | **Get ownership history for lighter** |
| **/api/location/update** | **POST** | **Update lighter location** |
| **/api/location/request** | **POST** | **Request location update from user** |
| **/api/qr/web/register** | **POST** | **Handle web-based QR registration** |

---

## 7. Enhanced Security & Performance

### 7.1 Security Measures
- HTTPS encryption for all API communication
- JWT token-based authentication with secure storage
- Password hashing using bcrypt (salt rounds: 10)
- OAuth 2.0 implementation for Google Sign-In
- Input validation and sanitization on all endpoints
- Rate limiting to prevent API abuse (100 requests/minute per user)
- SQL injection prevention through parameterized queries
- XSS protection through content security policies
- Regular security audits and penetration testing
- **Privacy controls for ownership history**
- **Secure location data handling**

### 7.2 Performance Optimization
- Database indexing on frequently queried fields (user_id, lighter_id, ownership_history)
- Image compression before upload (max 1MB per image)
- Caching frequently accessed data (user profiles, leaderboard, ownership history)
- Lazy loading for lighter collections (paginated results)
- CDN for static assets and images
- API response time target: < 200ms for most endpoints
- Background processing for non-critical tasks (analytics, email, location updates)
- Optimized database queries with proper joins
- Load balancing for high-traffic scenarios
- **Web QR page optimization for fast loading**

---

## 8. Enhanced Deployment Architecture

- **iOS App:** Deployed to Apple App Store via Xcode + App Store Connect
- **Backend API:** Hosted on AWS EC2 / Google Cloud Run / Vercel
- **Database:** Supabase (managed PostgreSQL) or Firebase Realtime Database
- **File Storage:** AWS S3 or Firebase Storage for user-uploaded images
- **Admin Dashboard:** Deployed on Vercel or Netlify (static hosting)
- **Landing Website:** Deployed on Vercel/Netlify with custom domain
- **QR Web Fallback:** Hosted on same infrastructure with CDN optimization
- **CI/CD Pipeline:** GitHub Actions for automated testing and deployment
- **Monitoring:** AWS CloudWatch / Firebase Analytics for performance tracking
- **Backup Strategy:** Daily automated database backups to secure cloud storage
- **Push Notifications:** Firebase Cloud Messaging (FCM) for all notification types

---

## 9. Future Expansion Readiness

### 9.1 Social Feed Architecture Foundation
- **Event Logging:** All user actions (trades, scans, location updates) logged for future social features
- **Activity Streams:** Database structure ready for activity feed generation
- **User Interaction Tracking:** All social interactions captured for future analysis
- **Scalable Infrastructure:** Built to handle increased social activity and engagement

### 9.2 Data Structure for Future Features
- **Modular API Design:** Easy to add new endpoints for social features
- **Flexible Database Schema:** Ready for additional social-related tables
- **Event-Driven Architecture:** Foundation for real-time social updates
- **Analytics Foundation:** Comprehensive tracking for future business intelligence

---

**This document forms Annex 2 of the Application Development Agreement between Good Monkeys LLC and CodeFlow Studios, dated October 8, 2025.**



