#!/usr/bin/env python3
"""
Create Annexures for Flick MVP Agreement
Annex 1: Detailed Scope of Work
Annex 2: Application Flow Diagram
"""

from reportlab.lib.pagesizes import letter, A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch, cm
from reportlab.lib.colors import Color, HexColor
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak, KeepTogether, ListFlowable, ListItem
from reportlab.lib.enums import TA_CENTER, TA_LEFT, TA_JUSTIFY, TA_RIGHT
from reportlab.platypus import Table, TableStyle, Image
from reportlab.lib import colors
from reportlab.platypus.flowables import HRFlowable
from reportlab.graphics.shapes import Drawing, Rect, String, Line
from reportlab.graphics import renderPDF
import PyPDF2
import os

def create_annex_1():
    """Create Annex 1: Detailed Scope of Work"""
    
    filename = "/Users/tayyab/Desktop/flick/Annex1_Detailed_Scope_of_Work.pdf"
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
    light_gray = HexColor('#f8f9fa')
    text_gray = HexColor('#333333')
    
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
    story.append(Paragraph("ANNEX 1", title_style))
    story.append(Paragraph("Detailed Scope of Work", section_style))
    story.append(Paragraph("Flick MVP - iOS Application Development", subsection_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("October 8, 2025", normal_style))
    story.append(HRFlowable(width="100%", thickness=2, color=primary_blue, spaceBefore=10, spaceAfter=20))
    
    # Introduction
    story.append(Paragraph("1. Introduction", section_style))
    story.append(Paragraph(
        "This document provides a comprehensive breakdown of all features, modules, and functionalities to be developed as part of the Flick MVP (Minimum Viable Product) for iOS platform. This annex forms an integral part of the Application Development Agreement between Good Monkeys LLC and CodeFlow Studios.",
        normal_style
    ))
    story.append(Spacer(1, 0.15*inch))
    
    story.append(Paragraph("1.1 Project Scope", subsection_style))
    story.append(Paragraph(
        "<b>Platform:</b> iOS (iPhone and iPad compatible)",
        normal_style
    ))
    story.append(Paragraph(
        "<b>Development Framework:</b> Flutter or React Native (cross-platform capable, optimized for iOS)",
        normal_style
    ))
    story.append(Paragraph(
        "<b>Backend:</b> Node.js with Express.js framework",
        normal_style
    ))
    story.append(Paragraph(
        "<b>Database:</b> Supabase or Firebase (cloud-hosted, scalable)",
        normal_style
    ))
    story.append(Paragraph(
        "<b>Cloud Infrastructure:</b> AWS, Vercel, or Google Cloud Platform",
        normal_style
    ))
    story.append(Paragraph(
        "<b>Note:</b> Android development is excluded from this MVP scope. Focus is exclusively on iOS platform delivery.",
        normal_style
    ))
    story.append(PageBreak())
    
    # Module Breakdown
    story.append(Paragraph("2. Core Modules & Features", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    # Module A: QR Scanning & Registration
    story.append(Paragraph("2.1 QR Scanning & Lighter Registration", subsection_style))
    story.append(Paragraph("Purpose: Enable users to scan QR codes on lighters and register them in their collection.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
    qr_features = [
        "QR code scanner using device camera (iOS native integration)",
        "Unique lighter ID generation and validation",
        "Lighter registration with metadata (brand, color, design, acquisition date)",
        "Photo capture functionality to document the lighter",
        "Duplicate detection to prevent multiple registrations of same lighter",
        "Registration confirmation with success notification",
        "History log of all scanned/registered lighters"
    ]
    
    for feature in qr_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # Module B: User Profiles
    story.append(Paragraph("2.2 User Profiles & Onboarding", subsection_style))
    story.append(Paragraph("Purpose: Create personalized user accounts with profile management and seamless onboarding.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
    profile_features = [
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
    
    for feature in profile_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # Module C: Lost & Found
    story.append(Paragraph("2.3 Lost & Found Workflow", subsection_style))
    story.append(Paragraph("Purpose: Allow users to report lost lighters and facilitate their recovery through community engagement.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
    lostfound_features = [
        "Report a lighter as 'Lost' with description and location",
        "Browse lost lighters in the community",
        "Mark a lighter as 'Found' when scanned by another user",
        "Notification system to alert original owner when lighter is found",
        "In-app messaging to coordinate lighter return",
        "Optional reward system (user can offer reward for return)",
        "Lost & Found history tracking",
        "Map view showing locations of reported lost lighters"
    ]
    
    for feature in lostfound_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(PageBreak())
    
    # Module D: Trading & Gifting
    story.append(Paragraph("2.4 Trading and Gifting Features", subsection_style))
    story.append(Paragraph("Purpose: Enable peer-to-peer lighter exchanges and gifts within the community.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
    trading_features = [
        "Browse available lighters for trade in community marketplace",
        "Send trade requests to other users",
        "Accept/reject trade offers with messaging",
        "Gift lighters to friends or community members",
        "Transfer ownership through secure transaction",
        "Trade history and transaction log",
        "Rating system for successful trades",
        "Search and filter lighters by brand, rarity, or design",
        "Wishlist functionality to track desired lighters"
    ]
    
    for feature in trading_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # Module E: Gamification
    story.append(Paragraph("2.5 Basic Gamification and Rewards (Lite Version)", subsection_style))
    story.append(Paragraph("Purpose: Encourage user engagement through achievements, points, and leaderboards.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
    gamification_features = [
        "Point system for various activities (scans, trades, referrals)",
        "Achievement badges (e.g., 'First Scan', 'Collector', 'Trader', 'Helper')",
        "Leaderboard showing top collectors and active users",
        "Level progression system (Bronze, Silver, Gold, Platinum tiers)",
        "Daily login rewards",
        "Referral bonus program",
        "Milestone celebrations (e.g., 10th lighter scanned)",
        "Exclusive digital collectibles for top users"
    ]
    
    for feature in gamification_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # Module F: Admin Dashboard
    story.append(Paragraph("2.6 Admin Dashboard", subsection_style))
    story.append(Paragraph("Purpose: Provide administrators with tools to manage the platform, users, and content.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
    admin_features = [
        "Web-based admin panel (accessible via browser)",
        "User management (view, edit, suspend, delete accounts)",
        "Lighter database management (view all registered lighters)",
        "Analytics dashboard (user growth, activity metrics, engagement rates)",
        "Content moderation tools (review flagged content, messages)",
        "Push notification broadcast system",
        "Report management (handle user reports and disputes)",
        "System configuration and settings",
        "Export data (CSV/Excel reports for analytics)"
    ]
    
    for feature in admin_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(PageBreak())
    
    # Module G: Backend & APIs
    story.append(Paragraph("2.7 Backend APIs and Cloud Integration", subsection_style))
    story.append(Paragraph("Purpose: Build robust, scalable backend infrastructure to support all app functionalities.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
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
        "Automated backup and data recovery system"
    ]
    
    for feature in backend_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # Module H: Mobile App
    story.append(Paragraph("2.8 Mobile App (iOS)", subsection_style))
    story.append(Paragraph("Purpose: Develop native-quality iOS application with intuitive UI/UX.", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
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
        "TestFlight beta testing setup"
    ]
    
    for feature in mobile_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # Module I: Additional Deliverable
    story.append(Paragraph("2.9 Landing Website for goodmonkeys.com", subsection_style))
    story.append(Paragraph("Purpose: Single-page marketing website (complimentary deliverable).", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
    website_features = [
        "Responsive single-page website design",
        "Hero section with app overview and download link",
        "Feature highlights section",
        "Screenshots gallery (carousel)",
        "Call-to-action buttons (Download from App Store)",
        "Contact form integration",
        "Social media links",
        "Mobile-optimized layout",
        "Fast loading and SEO optimization",
        "Hosting on Vercel or Netlify (included)"
    ]
    
    for feature in website_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(PageBreak())
    
    # Technical Specifications
    story.append(Paragraph("3. Technical Specifications", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    story.append(Paragraph("3.1 Technology Stack", subsection_style))
    
    tech_data = [
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
    
    tech_table = Table(tech_data, colWidths=[2.5*inch, 4*inch])
    tech_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 11),
        ('FONTSIZE', (0, 1), (-1, -1), 10),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 10),
        ('TOPPADDING', (0, 0), (-1, -1), 10),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE')
    ]))
    
    story.append(tech_table)
    story.append(Spacer(1, 0.15*inch))
    
    # Deliverables
    story.append(Paragraph("4. Project Deliverables", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    deliverables = [
        ("iOS Application", [
            "Production-ready app submitted to Apple App Store",
            "TestFlight build for beta testing",
            "Complete source code repository"
        ]),
        ("Backend Infrastructure", [
            "Deployed and configured cloud backend",
            "API documentation (Swagger/Postman collection)",
            "Database schema documentation"
        ]),
        ("Admin Dashboard", [
            "Web-based admin panel (deployed and accessible)",
            "Admin user manual and documentation"
        ]),
        ("Landing Website", [
            "Single-page website for goodmonkeys.com",
            "Deployed and live on production server"
        ]),
        ("Documentation", [
            "Technical documentation (architecture, API specs)",
            "User manual and onboarding guide",
            "Deployment and maintenance guide"
        ])
    ]
    
    for title, items in deliverables:
        story.append(Paragraph(f"<b>{title}:</b>", normal_style))
        for item in items:
            story.append(Paragraph(f"• {item}", bullet_style))
        story.append(Spacer(1, 0.08*inch))
    
    story.append(Spacer(1, 0.1*inch))
    
    # Exclusions
    story.append(Paragraph("5. Exclusions from Scope", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    exclusions = [
        "Android application development (excluded from MVP)",
        "Advanced AI/ML features (e.g., lighter image recognition)",
        "Payment gateway integration (no monetization in MVP)",
        "Third-party brand partnerships or integrations",
        "Advanced analytics and business intelligence tools",
        "Multi-language support (English only for MVP)",
        "Video content or streaming features"
    ]
    
    for exclusion in exclusions:
        story.append(Paragraph(f"• {exclusion}", bullet_style))
    
    story.append(PageBreak())
    
    # Testing & Quality Assurance
    story.append(Paragraph("6. Testing & Quality Assurance", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    story.append(Paragraph("6.1 Testing Approach", subsection_style))
    qa_items = [
        "Unit testing for backend APIs and critical functions",
        "Integration testing for end-to-end workflows",
        "iOS device testing (iPhone 12, 13, 14 series)",
        "iPad compatibility testing",
        "Performance testing (load times, API response times)",
        "Security testing (authentication, data protection)",
        "User acceptance testing (UAT) with Good Monkeys LLC team",
        "Beta testing via TestFlight with selected users"
    ]
    
    for item in qa_items:
        story.append(Paragraph(f"• {item}", bullet_style))
    
    story.append(Spacer(1, 0.15*inch))
    
    # Support & Maintenance
    story.append(Paragraph("7. Post-Launch Support (3 Months)", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    support_items = [
        "Bug fixes and critical issue resolution",
        "Security patches and updates",
        "Performance monitoring and optimization",
        "Minor UI/UX improvements based on user feedback",
        "iOS version updates (compatibility with latest iOS releases)",
        "Cloud infrastructure monitoring and maintenance",
        "Monthly progress reports and analytics review"
    ]
    
    for item in support_items:
        story.append(Paragraph(f"• {item}", bullet_style))
    
    story.append(Spacer(1, 0.2*inch))
    
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
    print(f"✅ Annex 1 created: {filename}")
    return filename


def create_annex_2():
    """Create Annex 2: Application Flow Diagram"""
    
    filename = "/Users/tayyab/Desktop/flick/Annex2_Application_Flow_Diagram.pdf"
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
    light_gray = HexColor('#f8f9fa')
    text_gray = HexColor('#333333')
    
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
    story.append(Paragraph("ANNEX 2", title_style))
    story.append(Paragraph("Application Flow Diagram", section_style))
    story.append(Paragraph("Flick MVP - iOS Application", subsection_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("October 8, 2025", normal_style))
    story.append(HRFlowable(width="100%", thickness=2, color=primary_blue, spaceBefore=10, spaceAfter=20))
    
    # Introduction
    story.append(Paragraph("1. Overview", section_style))
    story.append(Paragraph(
        "This document describes the overall application flow, user journeys, data interactions, and backend architecture for the Flick MVP iOS application. It provides a comprehensive view of how different modules interact with each other and with the backend infrastructure.",
        normal_style
    ))
    story.append(Spacer(1, 0.2*inch))
    
    # Application Architecture
    story.append(Paragraph("2. System Architecture", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    # Architecture diagram as table
    arch_data = [
        ['Layer', 'Components', 'Technology'],
        ['Presentation Layer', 'iOS Application (iPhone & iPad)', 'Flutter/React Native'],
        ['API Layer', 'RESTful API Gateway', 'Node.js + Express.js'],
        ['Business Logic Layer', 'Authentication, QR Processing, Trading Logic, Gamification Engine', 'Node.js'],
        ['Data Layer', 'User DB, Lighter DB, Transaction DB', 'Supabase/Firebase'],
        ['Storage Layer', 'Images, Documents, Backups', 'AWS S3 / Firebase Storage'],
        ['Infrastructure Layer', 'Cloud Hosting, Load Balancing', 'AWS/GCP/Vercel']
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
    
    # User Journey Flows
    story.append(Paragraph("3. Key User Journey Flows", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    # Flow 1: User Registration & Onboarding
    story.append(Paragraph("3.1 User Registration & Onboarding Flow", subsection_style))
    
    flow1_data = [
        ['Step', 'Action', 'System Response'],
        ['1', 'User downloads app from App Store', 'App launches with splash screen'],
        ['2', 'User sees welcome screen', 'Display registration options (Email/Google OAuth)'],
        ['3', 'User selects registration method', 'Navigate to respective auth flow'],
        ['4', 'User provides credentials', 'Backend validates and creates account'],
        ['5', 'Email verification sent (if email signup)', 'User verifies email via link'],
        ['6', 'User completes profile (username, avatar)', 'Data stored in User DB'],
        ['7', 'Onboarding tutorial displayed', 'User learns key features'],
        ['8', 'User lands on home screen', 'Display personal collection (empty initially)']
    ]
    
    flow1_table = Table(flow1_data, colWidths=[0.6*inch, 2.7*inch, 3.2*inch])
    flow1_table.setStyle(TableStyle([
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
    
    story.append(flow1_table)
    story.append(Spacer(1, 0.15*inch))
    
    # Flow 2: QR Scanning & Lighter Registration
    story.append(Paragraph("3.2 QR Scanning & Lighter Registration Flow", subsection_style))
    
    flow2_data = [
        ['Step', 'Action', 'System Response'],
        ['1', 'User taps "Scan QR" button', 'Camera opens with QR scanner overlay'],
        ['2', 'User scans QR code on lighter', 'App validates QR code format'],
        ['3', 'QR validated successfully', 'Backend checks if lighter already registered'],
        ['4', 'If new lighter: show registration form', 'User enters lighter details (brand, color, notes)'],
        ['5', 'User takes photo of lighter', 'Photo uploaded to cloud storage'],
        ['6', 'User confirms registration', 'Backend creates lighter record, links to user'],
        ['7', 'Success notification displayed', 'Lighter added to user collection'],
        ['8', 'Points awarded for registration', 'Gamification system updates user score']
    ]
    
    flow2_table = Table(flow2_data, colWidths=[0.6*inch, 2.7*inch, 3.2*inch])
    flow2_table.setStyle(TableStyle([
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
    
    story.append(flow2_table)
    story.append(PageBreak())
    
    # Flow 3: Lost & Found Workflow
    story.append(Paragraph("3.3 Lost & Found Workflow", subsection_style))
    
    flow3_data = [
        ['Step', 'Action', 'System Response'],
        ['1', 'User reports lighter as lost', 'Opens "Report Lost" form with lighter details'],
        ['2', 'User provides description & last known location', 'Data saved to Lost & Found DB'],
        ['3', 'Lost lighter appears in community feed', 'Other users can see lost item listing'],
        ['4', 'Another user finds and scans the lighter', 'System detects lighter is marked as lost'],
        ['5', 'Finder sees "This lighter is lost" notification', 'Option to contact owner displayed'],
        ['6', 'Finder initiates contact', 'In-app message sent to original owner'],
        ['7', 'Owner and finder coordinate return', 'Chat system facilitates communication'],
        ['8', 'Owner confirms return', 'Lighter marked as recovered, finder awarded points']
    ]
    
    flow3_table = Table(flow3_data, colWidths=[0.6*inch, 2.7*inch, 3.2*inch])
    flow3_table.setStyle(TableStyle([
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
    
    story.append(flow3_table)
    story.append(Spacer(1, 0.15*inch))
    
    # Flow 4: Trading Workflow
    story.append(Paragraph("3.4 Trading Workflow", subsection_style))
    
    flow4_data = [
        ['Step', 'Action', 'System Response'],
        ['1', 'User browses marketplace', 'Display available lighters for trade'],
        ['2', 'User selects desired lighter', 'Show lighter details and owner profile'],
        ['3', 'User sends trade request', 'Select lighter from own collection to offer'],
        ['4', 'Trade request sent', 'Owner receives push notification'],
        ['5', 'Owner reviews trade offer', 'Can accept, reject, or counter-offer'],
        ['6', 'If accepted: trade initiated', 'Backend updates ownership records'],
        ['7', 'Both users confirm trade completion', 'Ownership transferred in database'],
        ['8', 'Trade recorded in history', 'Both users awarded trade points']
    ]
    
    flow4_table = Table(flow4_data, colWidths=[0.6*inch, 2.7*inch, 3.2*inch])
    flow4_table.setStyle(TableStyle([
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
    
    story.append(flow4_table)
    story.append(PageBreak())
    
    # Data Flow Diagram
    story.append(Paragraph("4. Data Flow Architecture", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    story.append(Paragraph("4.1 Authentication & Authorization Flow", subsection_style))
    auth_flow = [
        "User initiates login (Email/Google OAuth)",
        "iOS app sends credentials to API Gateway",
        "API validates credentials against User DB",
        "If valid: JWT token generated and returned",
        "iOS app stores JWT token securely (Keychain)",
        "All subsequent API calls include JWT token in header",
        "API validates token on each request",
        "Token expires after 24 hours, refresh required"
    ]
    
    for step in auth_flow:
        story.append(Paragraph(f"→ {step}", bullet_style))
    
    story.append(Spacer(1, 0.15*inch))
    
    story.append(Paragraph("4.2 QR Code Validation & Registration Flow", subsection_style))
    qr_flow = [
        "User scans QR code via iOS camera",
        "App extracts unique lighter ID from QR code",
        "App sends lighter ID to backend API for validation",
        "Backend checks if ID format is valid",
        "Backend queries Lighter DB to check if already registered",
        "If new: create new lighter record with user_id linkage",
        "Upload lighter photo to cloud storage (S3/Firebase)",
        "Update User DB to link lighter to user's collection",
        "Return success response with lighter details to app"
    ]
    
    for step in qr_flow:
        story.append(Paragraph(f"→ {step}", bullet_style))
    
    story.append(Spacer(1, 0.15*inch))
    
    story.append(Paragraph("4.3 Real-Time Messaging Flow (Lost & Found / Trading)", subsection_style))
    messaging_flow = [
        "User initiates chat (from lost & found or trade screen)",
        "App sends message via API to backend",
        "Backend stores message in Messages DB",
        "Backend sends push notification to recipient via FCM",
        "Recipient's app receives push notification",
        "Recipient opens chat, app fetches message history from API",
        "Real-time updates via WebSocket or polling (every 5 seconds)",
        "All messages encrypted in transit (HTTPS)"
    ]
    
    for step in messaging_flow:
        story.append(Paragraph(f"→ {step}", bullet_style))
    
    story.append(PageBreak())
    
    # Database Schema
    story.append(Paragraph("5. Database Schema Overview", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    story.append(Paragraph("5.1 Core Database Tables", subsection_style))
    
    db_data = [
        ['Table Name', 'Key Fields', 'Purpose'],
        ['users', 'user_id, email, username, avatar_url, created_at, points, level', 'Store user account information'],
        ['lighters', 'lighter_id, qr_code, owner_id, brand, color, photo_url, status, registered_at', 'Store registered lighter data'],
        ['trades', 'trade_id, requester_id, owner_id, lighter_offered_id, lighter_requested_id, status, created_at', 'Manage trade requests and history'],
        ['lost_found', 'report_id, lighter_id, reporter_id, status, description, last_location, reported_at', 'Track lost and found lighters'],
        ['messages', 'message_id, sender_id, recipient_id, content, timestamp, read_status', 'In-app messaging system'],
        ['achievements', 'achievement_id, user_id, badge_type, earned_at', 'Store user achievements and badges'],
        ['notifications', 'notification_id, user_id, type, content, read_status, created_at', 'Push notification records']
    ]
    
    db_table = Table(db_data, colWidths=[1.3*inch, 2.7*inch, 2.5*inch])
    db_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 10),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(db_table)
    story.append(Spacer(1, 0.2*inch))
    
    # API Endpoints
    story.append(Paragraph("6. Key API Endpoints", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    api_data = [
        ['Endpoint', 'Method', 'Purpose'],
        ['/api/auth/register', 'POST', 'User registration'],
        ['/api/auth/login', 'POST', 'User login'],
        ['/api/auth/oauth/google', 'POST', 'Google OAuth login'],
        ['/api/lighters/register', 'POST', 'Register new lighter'],
        ['/api/lighters/my-collection', 'GET', 'Fetch user\'s lighter collection'],
        ['/api/lighters/marketplace', 'GET', 'Browse available lighters for trade'],
        ['/api/trades/request', 'POST', 'Send trade request'],
        ['/api/trades/respond', 'PUT', 'Accept/reject trade'],
        ['/api/lost-found/report', 'POST', 'Report lighter as lost'],
        ['/api/lost-found/list', 'GET', 'Get list of lost lighters'],
        ['/api/messages/send', 'POST', 'Send message'],
        ['/api/messages/conversation/:userId', 'GET', 'Fetch conversation history'],
        ['/api/users/profile/:userId', 'GET', 'Get user profile'],
        ['/api/users/leaderboard', 'GET', 'Fetch leaderboard'],
        ['/api/notifications/send', 'POST', 'Send push notification']
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
    story.append(PageBreak())
    
    # Security & Performance
    story.append(Paragraph("7. Security & Performance Considerations", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    story.append(Paragraph("7.1 Security Measures", subsection_style))
    security_items = [
        "HTTPS encryption for all API communication",
        "JWT token-based authentication with secure storage",
        "Password hashing using bcrypt (salt rounds: 10)",
        "OAuth 2.0 implementation for Google Sign-In",
        "Input validation and sanitization on all endpoints",
        "Rate limiting to prevent API abuse (100 requests/minute per user)",
        "SQL injection prevention through parameterized queries",
        "XSS protection through content security policies",
        "Regular security audits and penetration testing"
    ]
    
    for item in security_items:
        story.append(Paragraph(f"• {item}", bullet_style))
    
    story.append(Spacer(1, 0.15*inch))
    
    story.append(Paragraph("7.2 Performance Optimization", subsection_style))
    performance_items = [
        "Database indexing on frequently queried fields (user_id, lighter_id)",
        "Image compression before upload (max 1MB per image)",
        "Caching frequently accessed data (user profiles, leaderboard)",
        "Lazy loading for lighter collections (paginated results)",
        "CDN for static assets and images",
        "API response time target: < 200ms for most endpoints",
        "Background processing for non-critical tasks (analytics, email)",
        "Optimized database queries with proper joins",
        "Load balancing for high-traffic scenarios"
    ]
    
    for item in performance_items:
        story.append(Paragraph(f"• {item}", bullet_style))
    
    story.append(Spacer(1, 0.2*inch))
    
    # Deployment Architecture
    story.append(Paragraph("8. Deployment Architecture", section_style))
    story.append(Spacer(1, 0.1*inch))
    
    deployment_items = [
        "<b>iOS App:</b> Deployed to Apple App Store via Xcode + App Store Connect",
        "<b>Backend API:</b> Hosted on AWS EC2 / Google Cloud Run / Vercel",
        "<b>Database:</b> Supabase (managed PostgreSQL) or Firebase Realtime Database",
        "<b>File Storage:</b> AWS S3 or Firebase Storage for user-uploaded images",
        "<b>Admin Dashboard:</b> Deployed on Vercel or Netlify (static hosting)",
        "<b>Landing Website:</b> Deployed on Vercel/Netlify with custom domain",
        "<b>CI/CD Pipeline:</b> GitHub Actions for automated testing and deployment",
        "<b>Monitoring:</b> AWS CloudWatch / Firebase Analytics for performance tracking",
        "<b>Backup Strategy:</b> Daily automated database backups to secure cloud storage"
    ]
    
    for item in deployment_items:
        story.append(Paragraph(item, bullet_style))
    
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
    print(f"✅ Annex 2 created: {filename}")
    return filename


def merge_pdfs():
    """Merge original agreement with both annexures"""
    
    original_pdf = "/Users/tayyab/Desktop/flick/V03_GoodMonkeys_CodeFlowStudios_FlickApp_08.10.2025.pdf"
    annex1_pdf = "/Users/tayyab/Desktop/flick/Annex1_Detailed_Scope_of_Work.pdf"
    annex2_pdf = "/Users/tayyab/Desktop/flick/Annex2_Application_Flow_Diagram.pdf"
    output_pdf = "/Users/tayyab/Desktop/flick/FINAL_GoodMonkeys_CodeFlowStudios_Agreement_with_Annexes.pdf"
    
    # Create PDF merger
    pdf_merger = PyPDF2.PdfMerger()
    
    # Add PDFs in order
    pdf_merger.append(original_pdf)
    pdf_merger.append(annex1_pdf)
    pdf_merger.append(annex2_pdf)
    
    # Write merged PDF
    with open(output_pdf, 'wb') as output_file:
        pdf_merger.write(output_file)
    
    pdf_merger.close()
    
    print(f"✅ Final document created with all annexures: {output_pdf}")
    return output_pdf


if __name__ == "__main__":
    print("Creating Annex 1: Detailed Scope of Work...")
    create_annex_1()
    
    print("\nCreating Annex 2: Application Flow Diagram...")
    create_annex_2()
    
    print("\nMerging all documents...")
    final_doc = merge_pdfs()
    
    print("\n✅ All documents created successfully!")
    print(f"📄 Final document: {final_doc}")






