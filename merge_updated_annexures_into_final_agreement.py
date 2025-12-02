#!/usr/bin/env python3
"""
Merge updated annexures into the final agreement document
"""

import PyPDF2
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

def create_final_updated_annex1():
    """Create the final updated Annex 1"""
    
    filename = "/Users/tayyab/Desktop/flick/Final_Updated_Annex1.pdf"
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
    story.append(Paragraph("ANNEX 1", title_style))
    story.append(Paragraph("Detailed Scope of Work", section_style))
    story.append(Paragraph("Flick MVP - iOS Application Development", subsection_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("October 8, 2025", normal_style))
    story.append(HRFlowable(width="100%", thickness=2, color=primary_blue, spaceBefore=10, spaceAfter=20))
    
    # Introduction
    story.append(Paragraph("1. Introduction", section_style))
    story.append(Paragraph(
        "This document provides a comprehensive breakdown of all features, modules, and functionalities to be developed as part of the Flick MVP (Minimum Viable Product) for iOS platform, including all additional features requested by Good Monkeys LLC. This annex forms an integral part of the Application Development Agreement between Good Monkeys LLC and CodeFlow Studios.",
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
    
    # Enhanced QR Code Scanning
    story.append(Paragraph("2.1 Enhanced QR Code Scanning & Lighter Registration", section_style))
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
        "Duplicate detection to prevent multiple registrations"
    ]
    
    for feature in qr_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # Ownership History
    story.append(Paragraph("2.2 Ownership History Tracking", section_style))
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
        "Privacy controls to remain anonymous in ownership history"
    ]
    
    for feature in ownership_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # Smart Location Updates
    story.append(Paragraph("2.3 Smart Location Update System", section_style))
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
        "Location-based lighter tracking"
    ]
    
    for feature in location_features:
        story.append(Paragraph(f"• {feature}", bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    # Enhanced Website
    story.append(Paragraph("2.4 Landing Website for goodmonkeys.com", section_style))
    story.append(Paragraph("Purpose: Single-page marketing website (complimentary deliverable).", normal_style))
    story.append(Spacer(1, 0.05*inch))
    story.append(Paragraph("Features:", normal_style))
    
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
    
    story.append(Spacer(1, 0.15*inch))
    
    # Enhanced Database Schema
    story.append(Paragraph("3. Enhanced Database Schema", section_style))
    story.append(Paragraph("The following tables will store all data for the Flick MVP application:", normal_style))
    story.append(Spacer(1, 0.1*inch))
    
    db_data = [
        ['Table Name', 'Key Fields', 'Purpose'],
        ['users', 'user_id, email, username, avatar_url, created_at, points, level, privacy_settings', 'Store user account information and preferences'],
        ['lighters', 'lighter_id, qr_code, owner_id, brand, color, photo_url, status, registered_at, current_location', 'Store registered lighter data and current location'],
        ['ownership_history', 'history_id, lighter_id, previous_owner_id, new_owner_id, transfer_date, transfer_type', 'Track ownership changes and transfers'],
        ['location_updates', 'location_id, lighter_id, user_id, latitude, longitude, timestamp, is_lost', 'Store location tracking data and updates'],
        ['qr_web_sessions', 'session_id, qr_code, user_agent, ip_address, action_taken, timestamp', 'Track QR web interactions and sessions'],
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
        ('FONTSIZE', (0, 0), (-1, 0), 11),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(db_table)
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
    print(f"✅ Final Updated Annex 1 created: {filename}")
    return filename


def create_final_updated_annex2():
    """Create the final updated Annex 2"""
    
    filename = "/Users/tayyab/Desktop/flick/Final_Updated_Annex2.pdf"
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
    story.append(Paragraph("ANNEX 2", title_style))
    story.append(Paragraph("Application Flow Diagram", section_style))
    story.append(Paragraph("Flick MVP - iOS Application", subsection_style))
    story.append(Spacer(1, 0.1*inch))
    story.append(Paragraph("October 8, 2025", normal_style))
    story.append(HRFlowable(width="100%", thickness=2, color=primary_blue, spaceBefore=10, spaceAfter=20))
    
    # Overview
    story.append(Paragraph("1. Overview", section_style))
    story.append(Paragraph(
        "This document describes the overall application flow, user journeys, data interactions, and backend architecture for the Flick MVP iOS application, including all additional features requested by Good Monkeys LLC. It provides a comprehensive view of how different modules interact with each other and with the backend infrastructure.",
        normal_style
    ))
    story.append(Spacer(1, 0.2*inch))
    
    # Enhanced Architecture
    story.append(Paragraph("2. Enhanced System Architecture", section_style))
    
    arch_data = [
        ['Layer', 'Components', 'Technology'],
        ['Presentation Layer', 'iOS Application + Web QR Fallback', 'Flutter/React Native + HTML/CSS/JS'],
        ['API Layer', 'RESTful API Gateway', 'Node.js + Express.js'],
        ['Business Logic Layer', 'QR Processing, Location Tracking, Ownership History', 'Node.js'],
        ['Data Layer', 'User DB, Lighter DB, Ownership History DB, Location DB', 'Supabase/Firebase'],
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
    
    # Enhanced QR Flow
    story.append(Paragraph("3. Enhanced QR Code Scanning Flow", section_style))
    
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
    
    # Smart Location Update Flow
    story.append(Paragraph("4. Smart Location Update Flow", section_style))
    
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
    story.append(PageBreak())
    
    # Enhanced API Endpoints
    story.append(Paragraph("5. Enhanced API Endpoints", section_style))
    
    api_data = [
        ['Endpoint', 'Method', 'Purpose'],
        ['/api/lighters/qr/validate', 'POST', 'Validate QR code and return status'],
        ['/api/lighters/qr/web/action', 'POST', 'Handle QR web actions (return/claim/register)'],
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
    
    # Future Expansion
    story.append(Paragraph("6. Future Expansion Readiness", section_style))
    story.append(Paragraph("6.1 Social Feed Architecture Foundation", subsection_style))
    
    future_items = [
        "Event Logging: All user actions (trades, scans, location updates) logged for future social features",
        "Activity Streams: Database structure ready for activity feed generation",
        "User Interaction Tracking: All social interactions captured for future analysis",
        "Scalable Infrastructure: Built to handle increased social activity and engagement"
    ]
    
    for item in future_items:
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
    print(f"✅ Final Updated Annex 2 created: {filename}")
    return filename


def merge_updated_annexures_into_final_agreement():
    """Merge updated annexures into the final agreement document"""
    
    # Read the existing final agreement (first 6 pages)
    original_agreement = "/Users/tayyab/Desktop/flick/FINAL_GoodMonkeys_CodeFlowStudios_Agreement_with_Annexes (2).pdf"
    updated_annex1 = "/Users/tayyab/Desktop/flick/Final_Updated_Annex1.pdf"
    updated_annex2 = "/Users/tayyab/Desktop/flick/Final_Updated_Annex2.pdf"
    final_output = "/Users/tayyab/Desktop/flick/FINAL_SIGNED_GoodMonkeys_CodeFlowStudios_Agreement_UPDATED.pdf"
    
    # Create PDF merger
    pdf_merger = PyPDF2.PdfMerger()
    
    try:
        # Add original agreement pages (first 6 pages only - the main agreement without old annexures)
        with open(original_agreement, 'rb') as file:
            original_reader = PyPDF2.PdfReader(file)
            # Add only the first 6 pages (main agreement)
            for i in range(min(6, len(original_reader.pages))):
                pdf_merger.append(original_reader.pages[i])
        
        # Add updated Annex 1
        pdf_merger.append(updated_annex1)
        
        # Add updated Annex 2
        pdf_merger.append(updated_annex2)
        
        # Write merged PDF
        with open(final_output, 'wb') as output_file:
            pdf_merger.write(output_file)
        
        pdf_merger.close()
        
        print(f"✅ Final updated agreement created: {final_output}")
        return final_output
        
    except Exception as e:
        print(f"Error merging PDFs: {e}")
        return None


if __name__ == "__main__":
    print("Creating final updated annexures...")
    
    print("\nCreating Final Updated Annex 1...")
    annex1_pdf = create_final_updated_annex1()
    
    print("\nCreating Final Updated Annex 2...")
    annex2_pdf = create_final_updated_annex2()
    
    print("\nMerging updated annexures into final agreement...")
    final_doc = merge_updated_annexures_into_final_agreement()
    
    if final_doc:
        print(f"\n✅ Final updated agreement created successfully!")
        print(f"📄 Final document: {final_doc}")
        print(f"🚀 Ready for signing!")
    else:
        print("\n❌ Error creating final document")


