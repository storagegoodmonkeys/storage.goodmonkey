#!/usr/bin/env python3
"""
Fix readability issues in Updated Annex 1 PDF
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
import os

def create_readable_annex1_pdf():
    """Create Updated Annex 1 PDF with better readability"""
    
    filename = "/Users/tayyab/Desktop/flick/Updated_Annex1_Detailed_Scope_FIXED.pdf"
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
    
    # Custom styles with better readability
    title_style = ParagraphStyle(
        'AnnexTitle',
        parent=styles['Heading1'],
        fontSize=26,
        spaceAfter=25,
        alignment=TA_CENTER,
        textColor=primary_blue,
        fontName='Helvetica-Bold',
        leading=32
    )
    
    section_style = ParagraphStyle(
        'AnnexSection',
        parent=styles['Heading2'],
        fontSize=18,
        spaceAfter=15,
        alignment=TA_LEFT,
        textColor=dark_gray,
        fontName='Helvetica-Bold',
        leading=22
    )
    
    subsection_style = ParagraphStyle(
        'AnnexSubsection',
        parent=styles['Heading3'],
        fontSize=14,
        spaceAfter=10,
        alignment=TA_LEFT,
        textColor=primary_blue,
        fontName='Helvetica-Bold',
        leading=18
    )
    
    normal_style = ParagraphStyle(
        'AnnexNormal',
        parent=styles['Normal'],
        fontSize=12,
        spaceAfter=8,
        alignment=TA_JUSTIFY,
        textColor=text_gray,
        fontName='Helvetica',
        leading=16
    )
    
    bullet_style = ParagraphStyle(
        'AnnexBullet',
        parent=styles['Normal'],
        fontSize=11,
        spaceAfter=6,
        alignment=TA_LEFT,
        textColor=text_gray,
        fontName='Helvetica',
        leftIndent=25,
        leading=15
    )
    
    # Title Page
    story.append(Spacer(1, 0.2*inch))
    story.append(Paragraph("ANNEX 1 - UPDATED", title_style))
    story.append(Paragraph("Detailed Scope of Work", section_style))
    story.append(Paragraph("Flick MVP - iOS Application Development", subsection_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("October 8, 2025", normal_style))
    story.append(HRFlowable(width="100%", thickness=2, color=primary_blue, spaceBefore=15, spaceAfter=25))
    
    # Introduction
    story.append(Paragraph("1. Introduction", section_style))
    story.append(Paragraph(
        "This document provides a comprehensive breakdown of all features, modules, and functionalities to be developed as part of the Flick MVP (Minimum Viable Product) for iOS platform, <b>including all additional features requested by Good Monkeys LLC</b>. This annex forms an integral part of the Application Development Agreement between Good Monkeys LLC and CodeFlow Studios.",
        normal_style
    ))
    story.append(Spacer(1, 0.2*inch))
    
    story.append(Paragraph("1.1 Project Scope", subsection_style))
    story.append(Paragraph("<b>Platform:</b> iOS (iPhone and iPad compatible)", normal_style))
    story.append(Paragraph("<b>Development Framework:</b> Flutter or React Native (cross-platform capable, optimized for iOS)", normal_style))
    story.append(Paragraph("<b>Backend:</b> Node.js with Express.js framework", normal_style))
    story.append(Paragraph("<b>Database:</b> Supabase or Firebase (cloud-hosted, scalable)", normal_style))
    story.append(Paragraph("<b>Cloud Infrastructure:</b> AWS, Vercel, or Google Cloud Platform", normal_style))
    story.append(Paragraph("<b>Note:</b> Android development is excluded from this MVP scope. Focus is exclusively on iOS platform delivery.", normal_style))
    story.append(PageBreak())
    
    # Enhanced QR Code Scanning
    story.append(Paragraph("2.1 Enhanced QR Code Scanning & Lighter Registration", section_style))
    story.append(Paragraph("Purpose: Enable users to scan QR codes using native iOS camera and provide comprehensive web-based fallback system.", normal_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
    qr_features = [
        "Native iOS Camera Integration: Users can scan QR codes directly using their phone's native camera app",
        "Deep Linking: If app is installed, QR scan opens app directly to relevant screen",
        "Web Fallback System: If app not installed, QR opens web page with notification-style interface",
        "Smart Routing Logic: Registered lighter shows return/claim options, unregistered shows download prompt",
        "In-App QR Scanner: Available for registered users within the app",
        "Unique lighter ID generation and validation",
        "Photo capture functionality to document the lighter",
        "Duplicate detection to prevent multiple registrations"
    ]
    
    for feature in qr_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.15*inch))
    
    # Ownership History
    story.append(Paragraph("2.2 Ownership History Tracking", section_style))
    story.append(Paragraph("Purpose: Allow users to view the ownership chain of registration status.", normal_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
    ownership_features = [
        "Ownership chain tracking in database schema",
        "Privacy-respecting display (only public profiles shown)",
        "Clean timeline view: \"X → A → B → You\"",
        "Optional privacy settings for each user",
        "Integration with existing trade/lost & found workflows",
        "View previous owners' publicly shared details",
        "Privacy controls to remain anonymous in ownership history"
    ]
    
    for feature in ownership_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.15*inch))
    
    # Smart Location Updates
    story.append(Paragraph("2.3 Smart Location Update System", section_style))
    story.append(Paragraph("Purpose: Proactively track lighter locations through user-friendly notifications.", normal_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
    location_features = [
        "Smart push notifications asking \"Is your lighter with you?\"",
        "One-tap responses (Yes/No)",
        "Automatic location updates when user confirms",
        "Follow-up \"Is it lost?\" flow for missing lighters",
        "Non-intrusive frequency (max 1-2 prompts per week)",
        "Respects user privacy and battery life",
        "Location-based lighter tracking"
    ]
    
    for feature in location_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(PageBreak())
    
    # Enhanced Website
    story.append(Paragraph("2.4 Landing Website for goodmonkeys.com", section_style))
    story.append(Paragraph("Purpose: Single-page marketing website (complimentary deliverable).", normal_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("<b>Features:</b>", normal_style))
    
    website_features = [
        "Company Section: About Good Monkeys LLC, mission, team",
        "Flick App Section: App introduction, features showcase, download buttons",
        "Contact Form: Professional contact system with email forwarding",
        "Responsive Design: Mobile-optimized for all devices",
        "SEO Optimized: Ready for search engine visibility",
        "Integrated Experience: Seamless flow between company info and app promotion"
    ]
    
    for feature in website_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.2*inch))
    
    # Enhanced Database Schema - FIXED FOR READABILITY
    story.append(Paragraph("3. Enhanced Database Schema", section_style))
    story.append(Paragraph("The following tables will store all data for the Flick MVP application:", normal_style))
    story.append(Spacer(1, 0.15*inch))
    
    # Create a more readable table with better spacing
    db_data = [
        ['Table Name', 'Key Fields', 'Purpose'],
        ['users', 'user_id, email, username, avatar_url, created_at, points, level, privacy_settings', 'Store user account information and preferences'],
        ['', '', ''],
        ['lighters', 'lighter_id, qr_code, owner_id, brand, color, photo_url, status, registered_at, current_location', 'Store registered lighter data and current location'],
        ['', '', ''],
        ['ownership_history', 'history_id, lighter_id, previous_owner_id, new_owner_id, transfer_date, transfer_type', 'Track ownership changes and transfers'],
        ['', '', ''],
        ['location_updates', 'location_id, lighter_id, user_id, latitude, longitude, timestamp, is_lost', 'Store location tracking data and updates'],
        ['', '', ''],
        ['qr_web_sessions', 'session_id, qr_code, user_agent, ip_address, action_taken, timestamp', 'Track QR web interactions and sessions']
    ]
    
    db_table = Table(db_data, colWidths=[1.8*inch, 3.2*inch, 2.5*inch])
    db_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 12),
        ('FONTSIZE', (0, 1), (-1, -1), 11),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 12),
        ('TOPPADDING', (0, 0), (-1, -1), 12),
        ('LEFTPADDING', (0, 0), (-1, -1), 12),
        ('RIGHTPADDING', (0, 0), (-1, -1), 12),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP'),
        # Hide empty rows
        ('FONTSIZE', (0, 1), (-1, 1), 1),
        ('FONTSIZE', (0, 3), (-1, 3), 1),
        ('FONTSIZE', (0, 5), (-1, 5), 1),
        ('FONTSIZE', (0, 7), (-1, 7), 1),
        ('FONTSIZE', (0, 9), (-1, 9), 1),
        ('BACKGROUND', (0, 1), (-1, 1), colors.white),
        ('BACKGROUND', (0, 3), (-1, 3), colors.white),
        ('BACKGROUND', (0, 5), (-1, 5), colors.white),
        ('BACKGROUND', (0, 7), (-1, 7), colors.white),
        ('BACKGROUND', (0, 9), (-1, 9), colors.white),
    ]))
    
    story.append(db_table)
    story.append(Spacer(1, 0.25*inch))
    
    # Additional Features Summary
    story.append(Paragraph("4. Additional Features Summary", section_style))
    story.append(Paragraph("All requested features have been integrated into the MVP scope:", normal_style))
    story.append(Spacer(1, 0.1*inch))
    
    additional_features = [
        "Enhanced QR code scanning with native iOS camera integration",
        "Web-based fallback system for non-app users",
        "Smart location tracking with push notifications",
        "Ownership history tracking with privacy controls",
        "Enhanced landing website with company branding",
        "Future-ready architecture for social features"
    ]
    
    for feature in additional_features:
        story.append(Paragraph(f"✅ {feature}", bullet_style))
    
    story.append(Spacer(1, 0.2*inch))
    
    # Footer
    story.append(HRFlowable(width="100%", thickness=1, color=dark_gray, spaceBefore=25, spaceAfter=15))
    story.append(Paragraph(
        "This document forms Annex 1 of the Application Development Agreement between Good Monkeys LLC and CodeFlow Studios, dated October 8, 2025.",
        ParagraphStyle(
            'Footer',
            parent=styles['Normal'],
            fontSize=11,
            alignment=TA_CENTER,
            textColor=dark_gray,
            fontName='Helvetica-Oblique'
        )
    ))
    
    # Build PDF
    doc.build(story)
    print(f"✅ Fixed Annex 1 PDF created: {filename}")
    return filename


if __name__ == "__main__":
    print("Creating fixed, readable Annex 1 PDF...")
    fixed_pdf = create_readable_annex1_pdf()
    print(f"\n✅ Fixed PDF created: {fixed_pdf}")
    print("📄 The table is now much more readable with better spacing and font sizes!")



