#!/usr/bin/env python3
"""
Create complete Annex 1 and Annex 2 with ALL original MVP features PLUS additional features
"""

from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.lib.colors import HexColor
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak
from reportlab.lib.enums import TA_CENTER, TA_LEFT, TA_JUSTIFY
from reportlab.platypus import Table, TableStyle
from reportlab.lib import colors
from reportlab.platypus.flowables import HRFlowable

def create_complete_annex1():
    """Create complete Annex 1 with ALL original MVP features PLUS additional features"""
    
    filename = "/Users/tayyab/Desktop/flick/COMPLETE_Annex1_Detailed_Scope_of_Work.pdf"
    doc = SimpleDocTemplate(
        filename,
        pagesize=A4,
        rightMargin=1*inch,
        leftMargin=1*inch,
        topMargin=1*inch,
        bottomMargin=1*inch
    )
    
    story = []
    styles = getSampleStyleSheet()
    
    # Custom colors
    primary_blue = HexColor('#667eea')
    dark_gray = HexColor('#2c3e50')
    text_gray = HexColor('#333333')
    light_gray = HexColor('#f8f9fa')
    
    # Custom styles
    title_style = ParagraphStyle(
        'AnnexTitle',
        parent=styles['Heading1'],
        fontSize=24,
        spaceAfter=20,
        alignment=TA_CENTER,
        textColor=primary_blue,
        fontName='Helvetica-Bold',
        leading=30
    )
    
    section_style = ParagraphStyle(
        'AnnexSection',
        parent=styles['Heading2'],
        fontSize=16,
        spaceAfter=12,
        alignment=TA_LEFT,
        textColor=dark_gray,
        fontName='Helvetica-Bold',
        leading=20
    )
    
    subsection_style = ParagraphStyle(
        'AnnexSubsection',
        parent=styles['Heading3'],
        fontSize=13,
        spaceAfter=8,
        alignment=TA_LEFT,
        textColor=primary_blue,
        fontName='Helvetica-Bold',
        leading=16
    )
    
    normal_style = ParagraphStyle(
        'AnnexNormal',
        parent=styles['Normal'],
        fontSize=10,
        spaceAfter=6,
        alignment=TA_JUSTIFY,
        textColor=text_gray,
        fontName='Helvetica',
        leading=13
    )
    
    bullet_style = ParagraphStyle(
        'AnnexBullet',
        parent=styles['Normal'],
        fontSize=10,
        spaceAfter=4,
        alignment=TA_LEFT,
        textColor=text_gray,
        fontName='Helvetica',
        leftIndent=20,
        leading=13
    )
    
    # Title Page
    story.append(Spacer(1, 0.3*inch))
    story.append(Paragraph("ANNEX 1 - COMPLETE", title_style))
    story.append(Paragraph("Detailed Scope of Work", section_style))
    story.append(Paragraph("Flick MVP - iOS Application Development", subsection_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("October 8, 2025", normal_style))
    story.append(HRFlowable(width="100%", thickness=2, color=primary_blue, spaceBefore=10, spaceAfter=20))
    
    # Introduction
    story.append(Paragraph("1. Introduction", section_style))
    story.append(Paragraph(
        "This document provides a comprehensive breakdown of ALL features, modules, and functionalities to be developed as part of the Flick MVP (Minimum Viable Product) for iOS platform, including ALL additional features requested by Good Monkeys LLC. This annex forms an integral part of the Application Development Agreement between Good Monkeys LLC and CodeFlow Studios.",
        normal_style
    ))
    story.append(Spacer(1, 0.15*inch))
    
    story.append(Paragraph("1.1 Project Scope", subsection_style))
    story.append(Paragraph("Platform: iOS (iPhone and iPad compatible)", normal_style))
    story.append(Paragraph("Development Framework: Flutter or React Native (cross-platform capable, optimized for iOS)", normal_style))
    story.append(Paragraph("Backend: Node.js with Express.js framework", normal_style))
    story.append(Paragraph("Database: Supabase or Firebase (cloud-hosted, scalable)", normal_style))
    story.append(Paragraph("Cloud Infrastructure: AWS, Vercel, or Google Cloud Platform", normal_style))
    story.append(Paragraph("Note: Android development is excluded from this MVP scope. Focus is exclusively on iOS platform delivery.", normal_style))
    story.append(PageBreak())
    
    # Core Modules & Features
    story.append(Paragraph("2. Core Modules & Features", section_style))
    
    # 2.1 Enhanced QR Code Scanning & Lighter Registration
    story.append(Paragraph("2.1 Enhanced QR Code Scanning & Lighter Registration", subsection_style))
    story.append(Paragraph("Purpose: Enable users to scan QR codes using native iOS camera and provide comprehensive web-based fallback system.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
    qr_features = [
        "Native iOS Camera Integration: Users can scan QR codes directly using their phone's native camera app",
        "Deep Linking: If app is installed, QR scan opens app directly to relevant screen",
        "Web Fallback System: If app not installed, QR opens web page with notification-style interface",
        "Smart Routing Logic: Registered lighter shows return/claim options, unregistered shows download prompt",
        "In-App QR Scanner: Available for registered users within the app",
        "Unique lighter ID generation and validation",
        "Photo capture functionality to document the lighter",
        "Duplicate detection to prevent multiple registrations",
        "Registration confirmation with success notification",
        "History log of all scanned/registered lighters"
    ]
    
    for feature in qr_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # 2.2 User Profiles & Onboarding
    story.append(Paragraph("2.2 User Profiles & Onboarding", subsection_style))
    story.append(Paragraph("Purpose: Create personalized user accounts with profile management and seamless onboarding.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
    user_features = [
        "User registration with email or social OAuth (Google Sign-In)",
        "Profile creation with username, avatar, bio, and location",
        "Email verification and password recovery",
        "Onboarding tutorial (first-time user walkthrough)",
        "Profile editing and customization",
        "Privacy settings (public/private profile)",
        "View personal lighter collection",
        "Activity feed showing recent scans, trades, and achievements",
        "Push notification preferences"
    ]
    
    for feature in user_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # 2.3 Ownership History Tracking
    story.append(Paragraph("2.3 Ownership History Tracking", subsection_style))
    story.append(Paragraph("Purpose: Allow users to view the ownership chain of lighters while respecting privacy preferences.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
    ownership_features = [
        "Ownership chain tracking in database schema",
        "Privacy-respecting display (only public profiles shown)",
        "Clean timeline view: \"X → A → B → You\"",
        "Optional privacy settings for each user",
        "Integration with existing trade/lost & found workflows",
        "View previous owners' publicly shared details",
        "Privacy controls to remain anonymous in ownership history",
        "Ownership transfer logging and history"
    ]
    
    for feature in ownership_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # 2.4 Smart Location Update System
    story.append(Paragraph("2.4 Smart Location Update System", subsection_style))
    story.append(Paragraph("Purpose: Proactively track lighter locations through user-friendly notifications.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
    location_features = [
        "Smart push notifications asking \"Is your lighter with you?\"",
        "One-tap responses (Yes/No)",
        "Automatic location updates when user confirms",
        "Follow-up \"Is it lost?\" flow for missing lighters",
        "Non-intrusive frequency (max 1-2 prompts per week)",
        "Respects user privacy and battery life",
        "Location-based lighter tracking",
        "Optional manual location updates",
        "Location history for lost & found purposes"
    ]
    
    for feature in location_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # 2.5 Lost & Found Workflow
    story.append(Paragraph("2.5 Lost & Found Workflow", subsection_style))
    story.append(Paragraph("Purpose: Allow users to report lost lighters and facilitate their recovery through community engagement.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
    lost_found_features = [
        "Report a lighter as 'Lost' with description and location",
        "Browse lost lighters in the community",
        "Mark a lighter as 'Found' when scanned by another user",
        "Notification system to alert original owner when lighter is found",
        "In-app messaging to coordinate lighter return",
        "Optional reward system (user can offer reward for return)",
        "Lost & Found history tracking",
        "Map view showing locations of reported lost lighters",
        "Integration with smart location update system"
    ]
    
    for feature in lost_found_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(PageBreak())
    
    # 2.6 Trading and Gifting Features
    story.append(Paragraph("2.6 Trading and Gifting Features", subsection_style))
    story.append(Paragraph("Purpose: Enable peer-to-peer lighter exchanges and gifts within the community.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
    trading_features = [
        "Browse available lighters for trade in community marketplace",
        "Send trade requests to other users",
        "Accept/reject trade offers with messaging",
        "Gift lighters to friends or community members",
        "Transfer ownership through secure transaction",
        "Trade history and transaction log",
        "Rating system for successful trades",
        "Search and filter lighters by brand, rarity, or design",
        "Wishlist functionality to track desired lighters",
        "Integration with ownership history tracking"
    ]
    
    for feature in trading_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # 2.7 Basic Gamification and Rewards
    story.append(Paragraph("2.7 Basic Gamification and Rewards (Lite Version)", subsection_style))
    story.append(Paragraph("Purpose: Encourage user engagement through achievements, points, and leaderboards.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
    gamification_features = [
        "Point system for various activities (scans, trades, referrals, location updates)",
        "Achievement badges (e.g., 'First Scan', 'Collector', 'Trader', 'Helper', 'Location Tracker')",
        "Leaderboard showing top collectors and active users",
        "Level progression system (Bronze, Silver, Gold, Platinum tiers)",
        "Daily login rewards",
        "Referral bonus program",
        "Milestone celebrations (e.g., 10th lighter scanned)",
        "Exclusive digital collectibles for top users",
        "Social sharing of achievements"
    ]
    
    for feature in gamification_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # 2.8 Admin Dashboard
    story.append(Paragraph("2.8 Admin Dashboard", subsection_style))
    story.append(Paragraph("Purpose: Provide administrators with tools to manage the platform, users, and content.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
    admin_features = [
        "Web-based admin panel (accessible via browser)",
        "User management (view, edit, suspend, delete accounts)",
        "Lighter database management (view all registered lighters)",
        "Analytics dashboard (user growth, activity metrics, engagement rates)",
        "Content moderation tools (review flagged content, messages)",
        "Push notification broadcast system",
        "Report management (handle user reports and disputes)",
        "System configuration and settings",
        "Export data (CSV/Excel reports for analytics)",
        "Ownership history management",
        "Location tracking analytics"
    ]
    
    for feature in admin_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # 2.9 Backend APIs and Cloud Integration
    story.append(Paragraph("2.9 Backend APIs and Cloud Integration", subsection_style))
    story.append(Paragraph("Purpose: Build robust, scalable backend infrastructure to support all app functionalities.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
    backend_features = [
        "RESTful API endpoints for all app features",
        "User authentication API (OAuth, JWT tokens)",
        "QR code validation and lighter registration API",
        "Real-time messaging API for trades and lost & found",
        "Push notification service integration (Firebase Cloud Messaging)",
        "Cloud storage for user photos and lighter images",
        "Database schema design and implementation",
        "API rate limiting and security measures",
        "Error handling and logging system",
        "Automated backup and data recovery system",
        "Social-ready architecture for future feed features",
        "Event logging system for activity tracking",
        "Scalable infrastructure for future expansion"
    ]
    
    for feature in backend_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # 2.10 Mobile App (iOS)
    story.append(Paragraph("2.10 Mobile App (iOS)", subsection_style))
    story.append(Paragraph("Purpose: Develop native-quality iOS application with intuitive UI/UX.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
    mobile_features = [
        "iOS-optimized user interface (iPhone 12 and above)",
        "iPad compatibility with responsive design",
        "Native iOS design patterns and gestures",
        "Smooth animations and transitions",
        "Offline mode for viewing personal collection",
        "Dark mode support",
        "In-app camera integration for QR scanning",
        "Location services integration (for lost & found features)",
        "Push notifications",
        "App Store deployment and optimization",
        "TestFlight beta testing setup",
        "Deep linking support for QR code scanning",
        "Native camera integration for QR scanning"
    ]
    
    for feature in mobile_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # 2.11 Landing Website for goodmonkeys.com
    story.append(Paragraph("2.11 Landing Website for goodmonkeys.com", subsection_style))
    story.append(Paragraph("Purpose: Single-page marketing website (complimentary deliverable).", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
    website_features = [
        "Company Section: About Good Monkeys LLC, mission, team",
        "Flick App Section: App introduction, features showcase, download buttons",
        "Contact Form: Professional contact system with email forwarding",
        "Responsive Design: Mobile-optimized for all devices",
        "SEO Optimized: Ready for search engine visibility",
        "Integrated Experience: Seamless flow between company info and app promotion",
        "Hero section with app overview and download link",
        "Feature highlights section",
        "Screenshots gallery (carousel)",
        "Call-to-action buttons (Download from App Store)",
        "Social media links",
        "Fast loading and SEO optimization",
        "Hosting on Vercel or Netlify (included)"
    ]
    
    for feature in website_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(PageBreak())
    
    # Technical Specifications
    story.append(Paragraph("3. Technical Specifications", section_style))
    
    # 3.1 Technology Stack
    story.append(Paragraph("3.1 Technology Stack", subsection_style))
    
    tech_stack_data = [
        ['Component', 'Technology'],
        ['Mobile Framework', 'Flutter or React Native'],
        ['Target Platform', 'iOS (iPhone & iPad)'],
        ['Backend Framework', 'Node.js + Express.js'],
        ['Database', 'Supabase or Firebase'],
        ['Authentication', 'OAuth 2.0 (Google) + Email/Password'],
        ['Cloud Infrastructure', 'AWS / GCP / Vercel'],
        ['Push Notifications', 'Firebase Cloud Messaging (FCM)'],
        ['File Storage', 'AWS S3 or Firebase Storage'],
        ['Version Control', 'GitHub']
    ]
    
    tech_stack_table = Table(tech_stack_data, colWidths=[2.5*inch, 3.5*inch])
    tech_stack_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 11),
        ('FONTSIZE', (0, 1), (-1, -1), 10),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(tech_stack_table)
    story.append(Spacer(1, 0.2*inch))
    
    # 3.2 Enhanced Database Schema
    story.append(Paragraph("3.2 Enhanced Database Schema", subsection_style))
    story.append(Paragraph("The following tables will store all data for the Flick MVP application:", normal_style))
    story.append(Spacer(1, 0.1*inch))
    
    db_data = [
        ['Table Name', 'Key Fields', 'Purpose'],
        ['users', 'user_id, email, username, avatar_url, created_at, points, level, privacy_settings, last_login, preferences', 'Store user registration and preferences'],
        ['lighters', 'lighter_id, qr_code, owner_id, brand, color, photo_url, status, registered_at, current_location', 'Store registered lighter data and location'],
        ['ownership_history', 'history_id, lighter_id, previous_owner_id, new_owner_id, transferred_at, transfer_type', 'Track ownership transfers'],
        ['location_updates', 'location_id, lighter_id, user_id, latitude, longitude, timestamp, status', 'Store location tracking data and updates'],
        ['qr_web_sessions', 'session_id, qr_code, user_agent, ip_address, action, timestamp', 'Track QR web interactions and sessions'],
        ['trades', 'trade_id, requester_id, owner_id, lighter_offered_id, lighter_requested_id, status, created_at', 'Manage trade requests and status'],
        ['lost_found', 'report_id, lighter_id, reporter_id, status, description, created_at', 'Track lost and reported lighters'],
        ['messages', 'message_id, sender_id, recipient_id, content, timestamp, read_status', 'Implement messaging system'],
        ['achievements', 'achievement_id, user_id, badge_type, earned_at', 'Store user achievements and badges'],
        ['notifications', 'notification_id, user_id, type, content, read_status, created_at', 'Create notification records']
    ]
    
    db_table = Table(db_data, colWidths=[1.3*inch, 2.7*inch, 2.5*inch])
    db_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 11),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(db_table)
    story.append(PageBreak())
    
    # Project Deliverables
    story.append(Paragraph("4. Project Deliverables", section_style))
    
    deliverables = [
        "iOS Application: Production-ready app submitted to Apple App Store",
        "TestFlight build for beta testing",
        "Complete source code repository",
        "Backend Infrastructure: Deployed and configured cloud backend",
        "API documentation (Swagger/Postman collection)",
        "Database schema documentation",
        "Admin Dashboard: Web-based admin panel (deployed and accessible)",
        "Admin user manual and documentation",
        "Landing Website: Single-page website for goodmonkeys.com",
        "Deployed and live on production server",
        "Documentation: Technical documentation (architecture, API specs)",
        "User manual and onboarding guide",
        "Deployment and maintenance guide"
    ]
    
    for deliverable in deliverables:
        story.append(Paragraph(f"• {deliverable}", bullet_style))
    
    story.append(Spacer(1, 0.2*inch))
    
    # Exclusions from Scope
    story.append(Paragraph("5. Exclusions from Scope", section_style))
    
    exclusions = [
        "Android application development (excluded from MVP)",
        "Advanced AI/ML features (e.g., lighter image recognition)",
        "Payment gateway integration (no monetization in MVP)",
        "Third-party brand partnerships or integrations",
        "Advanced analytics and business intelligence tools",
        "Multi-language support (English only for MVP)",
        "Video content or streaming features",
        "Advanced social media integration (basic social features included)"
    ]
    
    for exclusion in exclusions:
        story.append(Paragraph(f"• {exclusion}", bullet_style))
    
    story.append(Spacer(1, 0.3*inch))
    
    # Footer
    story.append(HRFlowable(width="100%", thickness=1, color=dark_gray, spaceBefore=20, spaceAfter=10))
    story.append(Paragraph(
        "This document forms Annex 1 of the Application Development Agreement between Good Monkeys LLC and CodeFlow Studios, dated October 8, 2025.",
        ParagraphStyle(
            'Footer',
            parent=styles['Normal'],
            fontSize=9,
            alignment=TA_CENTER,
            textColor=dark_gray,
            fontName='Helvetica-Oblique'
        )
    ))
    
    # Build PDF
    doc.build(story)
    print(f"✅ Complete Annex 1 created: {filename}")
    return filename


def create_complete_annex2():
    """Create complete Annex 2 with ALL original MVP features PLUS additional features"""
    
    filename = "/Users/tayyab/Desktop/flick/COMPLETE_Annex2_Application_Flow_Diagram.pdf"
    doc = SimpleDocTemplate(
        filename,
        pagesize=A4,
        rightMargin=0.75*inch,
        leftMargin=0.75*inch,
        topMargin=0.75*inch,
        bottomMargin=0.75*inch
    )
    
    story = []
    styles = getSampleStyleSheet()
    
    # Custom colors
    primary_blue = HexColor('#667eea')
    dark_gray = HexColor('#2c3e50')
    text_gray = HexColor('#333333')
    light_gray = HexColor('#f8f9fa')
    
    # Custom styles
    title_style = ParagraphStyle(
        'AnnexTitle',
        parent=styles['Heading1'],
        fontSize=24,
        spaceAfter=20,
        alignment=TA_CENTER,
        textColor=primary_blue,
        fontName='Helvetica-Bold',
        leading=30
    )
    
    section_style = ParagraphStyle(
        'AnnexSection',
        parent=styles['Heading2'],
        fontSize=16,
        spaceAfter=12,
        alignment=TA_LEFT,
        textColor=dark_gray,
        fontName='Helvetica-Bold',
        leading=20
    )
    
    subsection_style = ParagraphStyle(
        'AnnexSubsection',
        parent=styles['Heading3'],
        fontSize=13,
        spaceAfter=8,
        alignment=TA_LEFT,
        textColor=primary_blue,
        fontName='Helvetica-Bold',
        leading=16
    )
    
    normal_style = ParagraphStyle(
        'AnnexNormal',
        parent=styles['Normal'],
        fontSize=10,
        spaceAfter=6,
        alignment=TA_JUSTIFY,
        textColor=text_gray,
        fontName='Helvetica',
        leading=13
    )
    
    bullet_style = ParagraphStyle(
        'AnnexBullet',
        parent=styles['Normal'],
        fontSize=10,
        spaceAfter=4,
        alignment=TA_LEFT,
        textColor=text_gray,
        fontName='Helvetica',
        leftIndent=20,
        leading=13
    )
    
    # Title Page
    story.append(Spacer(1, 0.3*inch))
    story.append(Paragraph("ANNEX 2 - COMPLETE", title_style))
    story.append(Paragraph("Application Flow Diagram", section_style))
    story.append(Paragraph("Flick MVP - iOS Application", subsection_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("October 8, 2025", normal_style))
    story.append(HRFlowable(width="100%", thickness=2, color=primary_blue, spaceBefore=10, spaceAfter=20))
    
    # Overview
    story.append(Paragraph("1. Overview", section_style))
    story.append(Paragraph(
        "This document describes the overall application flow, user journeys, data interactions, and backend architecture for the Flick MVP iOS application, including ALL additional features requested by Good Monkeys LLC. It provides a comprehensive view of how different modules interact with each other and with the backend infrastructure.",
        normal_style
    ))
    story.append(Spacer(1, 0.2*inch))
    
    # System Architecture
    story.append(Paragraph("2. Enhanced System Architecture", section_style))
    
    arch_data = [
        ['Layer', 'Components', 'Technology'],
        ['Presentation Layer', 'iOS Application (iPhone & iPad) + Web QR Fallback', 'Flutter/React Native + HTML/CSS/JS'],
        ['API Layer', 'RESTful API Gateway', 'Node.js + Express.js'],
        ['Business Logic Layer', 'Authentication, QR Processing, Trading Logic, Gamification Engine, Location Tracking, Ownership History', 'Node.js'],
        ['Data Layer', 'User DB, Lighter DB, Transaction DB, Ownership History DB, Location DB', 'Supabase/Firebase'],
        ['Storage Layer', 'Images, Documents, Backups', 'AWS S3 / Firebase Storage'],
        ['Infrastructure Layer', 'Cloud Hosting, Load Balancing, CDN for Web QR', 'AWS/GCP/Vercel']
    ]
    
    arch_table = Table(arch_data, colWidths=[1.5*inch, 2.5*inch, 2.5*inch])
    arch_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 11),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(arch_table)
    story.append(PageBreak())
    
    # Key User Journey Flows
    story.append(Paragraph("3. Key User Journey Flows", section_style))
    
    # 3.1 Enhanced QR Code Scanning Flow
    story.append(Paragraph("3.1 Enhanced QR Code Scanning Flow", subsection_style))
    
    qr_flow_data = [
        ['Step', 'Action', 'System Response'],
        ['1', 'User scans QR code using native iOS camera', 'Camera app detects QR and attempts to open app'],
        ['2A', 'If app installed: Deep link to app', 'App opens directly to relevant screen'],
        ['2B', 'If app not installed: Open web page', 'Web page loads with notification-style interface'],
        ['3', 'System validates QR code format', 'Backend checks if QR exists in database'],
        ['4A', 'If registered lighter: Show ownership status', 'Display "This lighter is registered - return or claim?"'],
        ['4B', 'If unregistered lighter: Show registration prompt', 'Display "New lighter - add to collection!" with download link'],
        ['5', 'User takes action (return/claim/register)', 'System processes action and updates database'],
        ['6', 'Success confirmation displayed', 'User receives confirmation and next steps']
    ]
    
    qr_flow_table = Table(qr_flow_data, colWidths=[0.6*inch, 2.7*inch, 3.2*inch])
    qr_flow_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (0, -1), 'CENTER'),
        ('ALIGN', (1, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 10),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(qr_flow_table)
    story.append(Spacer(1, 0.15*inch))
    
    # 3.2 User Registration & Onboarding Flow
    story.append(Paragraph("3.2 User Registration & Onboarding Flow", subsection_style))
    
    registration_flow_data = [
        ['Step', 'Action', 'System Response'],
        ['1', 'User downloads app from App Store', 'App launches with splash screen'],
        ['2', 'User sees welcome screen', 'Display registration options (Email/Google OAuth)'],
        ['3', 'User selects registration method', 'Navigate to respective auth flow'],
        ['4', 'User provides credentials', 'Backend validates and creates account'],
        ['5', 'Email verification sent (if email signup)', 'User verifies email via link'],
        ['6', 'User completes profile (username, avatar, privacy settings)', 'Data stored in User DB'],
        ['7', 'Onboarding tutorial displayed', 'User learns key features including QR scanning'],
        ['8', 'User lands on home screen', 'Display personal collection (empty initially)']
    ]
    
    registration_flow_table = Table(registration_flow_data, colWidths=[0.6*inch, 2.7*inch, 3.2*inch])
    registration_flow_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (0, -1), 'CENTER'),
        ('ALIGN', (1, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 10),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(registration_flow_table)
    story.append(Spacer(1, 0.15*inch))
    
    # 3.3 Lost & Found Workflow
    story.append(Paragraph("3.3 Lost & Found Workflow", subsection_style))
    
    lost_found_flow_data = [
        ['Step', 'Action', 'System Response'],
        ['1', 'User reports lighter as lost', 'Opens "Report Lost" form with lighter details'],
        ['2', 'User provides description & last known location', 'Data saved to Lost & Found DB'],
        ['3', 'Lost lighter appears in community feed', 'Other users can see lost item listing'],
        ['4', 'Another user finds and scans the lighter', 'System detects lighter is marked as lost'],
        ['5', 'Finder sees "This lighter is lost" notification', 'Option to contact owner displayed'],
        ['6', 'Finder initiates contact', 'In-app message sent to original owner'],
        ['7', 'Owner and finder coordinate return', 'Chat system facilitates communication'],
        ['8', 'Owner confirms return', 'Lighter marked as recovered, finder awarded points'],
        ['9', 'Ownership history updated', 'Previous owner chain preserved']
    ]
    
    lost_found_flow_table = Table(lost_found_flow_data, colWidths=[0.6*inch, 2.7*inch, 3.2*inch])
    lost_found_flow_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (0, -1), 'CENTER'),
        ('ALIGN', (1, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 10),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(lost_found_flow_table)
    story.append(PageBreak())
    
    # 3.4 Trading Workflow
    story.append(Paragraph("3.4 Trading Workflow", subsection_style))
    
    trading_flow_data = [
        ['Step', 'Action', 'System Response'],
        ['1', 'User browses marketplace', 'Display available lighters for trade'],
        ['2', 'User selects desired lighter', 'Show lighter details, owner profile, and ownership history'],
        ['3', 'User sends trade request', 'Select lighter from own collection to offer'],
        ['4', 'Trade request sent', 'Owner receives push notification'],
        ['5', 'Owner reviews trade offer', 'Can accept, reject, or counter-offer'],
        ['6', 'If accepted: trade initiated', 'Backend updates ownership records'],
        ['7', 'Both users confirm trade completion', 'Ownership transferred in database'],
        ['8', 'Trade recorded in history', 'Both users awarded trade points'],
        ['9', 'Ownership history chain updated', 'New owner can view previous ownership chain']
    ]
    
    trading_flow_table = Table(trading_flow_data, colWidths=[0.6*inch, 2.7*inch, 3.2*inch])
    trading_flow_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (0, -1), 'CENTER'),
        ('ALIGN', (1, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 10),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(trading_flow_table)
    story.append(Spacer(1, 0.15*inch))
    
    # 3.5 Smart Location Update Flow
    story.append(Paragraph("3.5 Smart Location Update Flow", subsection_style))
    
    location_flow_data = [
        ['Step', 'Action', 'System Response'],
        ['1', 'System sends push notification', '"Is your lighter with you right now?"'],
        ['2', 'User responds Yes/No', 'One-tap response captured'],
        ['3A', 'If Yes: Location updated', 'Current GPS location saved to lighter record'],
        ['3B', 'If No: Follow-up question', '"Is your lighter lost?"'],
        ['4A', 'If lost: Mark as lost', 'Lighter status updated, owner notified'],
        ['4B', 'If not lost: Normal status', '"Just not with me right now" recorded'],
        ['5', 'System logs interaction', 'Analytics updated, frequency tracking']
    ]
    
    location_flow_table = Table(location_flow_data, colWidths=[0.6*inch, 2.7*inch, 3.2*inch])
    location_flow_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (0, -1), 'CENTER'),
        ('ALIGN', (1, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 10),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(location_flow_table)
    story.append(Spacer(1, 0.15*inch))
    
    # 3.6 Ownership History Viewing Flow
    story.append(Paragraph("3.6 Ownership History Viewing Flow", subsection_style))
    
    ownership_flow_data = [
        ['Step', 'Action', 'System Response'],
        ['1', 'User views lighter details', 'Display current lighter information'],
        ['2', 'User taps "View History"', 'Request ownership history from backend'],
        ['3', 'System retrieves ownership chain', 'Query database for previous owners'],
        ['4', 'Filter by privacy settings', 'Only show users with public profiles'],
        ['5', 'Display ownership timeline', 'Show "X → A → B → You" format'],
        ['6', 'User can view previous owner profiles', 'Display public profile information']
    ]
    
    ownership_flow_table = Table(ownership_flow_data, colWidths=[0.6*inch, 2.7*inch, 3.2*inch])
    ownership_flow_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (0, -1), 'CENTER'),
        ('ALIGN', (1, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 10),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(ownership_flow_table)
    story.append(PageBreak())
    
    # Enhanced API Endpoints
    story.append(Paragraph("4. Enhanced API Endpoints", section_style))
    
    api_data = [
        ['Endpoint', 'Method', 'Purpose'],
        ['/api/auth/register', 'POST', 'User registration'],
        ['/api/auth/login', 'POST', 'User login'],
        ['/api/auth/oauth/google', 'POST', 'Google OAuth login'],
        ['/api/lighters/register', 'POST', 'Register new lighter'],
        ['/api/lighters/my-collection', 'GET', 'Fetch user\'s lighter collection'],
        ['/api/lighters/marketplace', 'GET', 'Browse available lighters for trade'],
        ['/api/lighters/qr/validate', 'POST', 'Validate QR code and return status'],
        ['/api/lighters/qr/web/action', 'POST', 'Handle QR web actions (return/claim/register)'],
        ['/api/trades/request', 'POST', 'Send trade request'],
        ['/api/trades/respond', 'PUT', 'Accept/reject trade'],
        ['/api/lost-found/report', 'POST', 'Report lighter as lost'],
        ['/api/lost-found/list', 'GET', 'Get list of lost lighters'],
        ['/api/messages/send', 'POST', 'Send message'],
        ['/api/messages/conversation/:userId', 'GET', 'Fetch conversation history'],
        ['/api/users/profile/:userId', 'GET', 'Get user profile'],
        ['/api/users/leaderboard', 'GET', 'Fetch leaderboard'],
        ['/api/notifications/send', 'POST', 'Send push notification'],
        ['/api/lighters/:id/ownership-history', 'GET', 'Get ownership history for lighter'],
        ['/api/location/update', 'POST', 'Update lighter location'],
        ['/api/location/request', 'POST', 'Request location update from user'],
        ['/api/qr/web/register', 'POST', 'Handle web-based QR registration']
    ]
    
    api_table = Table(api_data, colWidths=[2.5*inch, 1*inch, 3*inch])
    api_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('ALIGN', (1, 0), (1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 10),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE')
    ]))
    
    story.append(api_table)
    story.append(Spacer(1, 0.2*inch))
    
    # Future Expansion Readiness
    story.append(Paragraph("5. Future Expansion Readiness", section_style))
    story.append(Paragraph("5.1 Social Feed Architecture Foundation", subsection_style))
    
    future_items = [
        "Event Logging: All user actions (trades, scans, location updates) logged for future social features",
        "Activity Streams: Database structure ready for activity feed generation",
        "User Interaction Tracking: All social interactions captured for future analysis",
        "Scalable Infrastructure: Built to handle increased social activity and engagement"
    ]
    
    for item in future_items:
        story.append(Paragraph(f"• {item}", bullet_style))
    
    story.append(Spacer(1, 0.2*inch))
    
    story.append(Paragraph("5.2 Data Structure for Future Features", subsection_style))
    
    future_data_items = [
        "Modular API Design: Easy to add new endpoints for social features",
        "Flexible Database Schema: Ready for additional social-related tables",
        "Event-Driven Architecture: Foundation for real-time social updates",
        "Analytics Foundation: Comprehensive tracking for future business intelligence"
    ]
    
    for item in future_data_items:
        story.append(Paragraph(f"• {item}", bullet_style))
    
    story.append(Spacer(1, 0.3*inch))
    
    # Footer
    story.append(HRFlowable(width="100%", thickness=1, color=dark_gray, spaceBefore=20, spaceAfter=10))
    story.append(Paragraph(
        "This document forms Annex 2 of the Application Development Agreement between Good Monkeys LLC and CodeFlow Studios, dated October 8, 2025.",
        ParagraphStyle(
            'Footer',
            parent=styles['Normal'],
            fontSize=9,
            alignment=TA_CENTER,
            textColor=dark_gray,
            fontName='Helvetica-Oblique'
        )
    ))
    
    # Build PDF
    doc.build(story)
    print(f"✅ Complete Annex 2 created: {filename}")
    return filename


def create_final_document_with_complete_annexures():
    """Create final document with complete annexures"""
    
    # Create complete annexures
    print("Creating complete annexures with ALL features...")
    annex1_path = create_complete_annex1()
    annex2_path = create_complete_annex2()
    
    # File paths
    original_final = "/Users/tayyab/Desktop/flick/Final.pdf"
    complete_annex1 = "/Users/tayyab/Desktop/flick/COMPLETE_Annex1_Detailed_Scope_of_Work.pdf"
    complete_annex2 = "/Users/tayyab/Desktop/flick/COMPLETE_Annex2_Application_Flow_Diagram.pdf"
    final_output = "/Users/tayyab/Desktop/flick/FINAL_COMPLETE_GoodMonkeys_CodeFlowStudios_Agreement.pdf"
    
    import PyPDF2
    import os
    
    # Check if files exist
    if not os.path.exists(original_final):
        print(f"❌ Original Final.pdf not found: {original_final}")
        return None
    
    try:
        # Create PDF writer
        pdf_writer = PyPDF2.PdfWriter()
        
        # Add original Final.pdf pages
        print("📄 Reading original Final.pdf...")
        with open(original_final, 'rb') as file:
            original_reader = PyPDF2.PdfReader(file)
            total_pages = len(original_reader.pages)
            print(f"📄 Original Final.pdf has {total_pages} pages")
            
            # Add all pages from original Final.pdf
            for i in range(total_pages):
                pdf_writer.add_page(original_reader.pages[i])
                print(f"📄 Added page {i+1} from original Final.pdf")
        
        # Add complete Annex 1
        print("📄 Adding Complete Annex 1...")
        with open(complete_annex1, 'rb') as file:
            annex1_reader = PyPDF2.PdfReader(file)
            for page in annex1_reader.pages:
                pdf_writer.add_page(page)
        
        # Add complete Annex 2
        print("📄 Adding Complete Annex 2...")
        with open(complete_annex2, 'rb') as file:
            annex2_reader = PyPDF2.PdfReader(file)
            for page in annex2_reader.pages:
                pdf_writer.add_page(page)
        
        # Write merged PDF
        print("📄 Creating final complete document...")
        with open(final_output, 'wb') as output_file:
            pdf_writer.write(output_file)
        
        print(f"✅ Final complete document created successfully!")
        print(f"📄 Final document: {final_output}")
        return final_output
        
    except Exception as e:
        print(f"❌ Error creating final complete document: {e}")
        return None


if __name__ == "__main__":
    print("Creating complete annexures with ALL original MVP features PLUS additional features...")
    final_doc = create_final_document_with_complete_annexures()
    
    if final_doc:
        print(f"\n✅ Final complete document created successfully!")
        print(f"📄 Final document: {final_doc}")
        print(f"🚀 Ready for client review!")
    else:
        print("\n❌ Error creating final complete document")


