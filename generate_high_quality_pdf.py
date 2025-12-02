#!/usr/bin/env python3
"""
High-Quality PDF Generator for CodeFlow Studios Proposal
Creates a professional, well-formatted PDF with proper styling
"""

from reportlab.lib.pagesizes import letter, A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch, cm
from reportlab.lib.colors import Color, HexColor
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak, KeepTogether
from reportlab.lib.enums import TA_CENTER, TA_LEFT, TA_JUSTIFY, TA_RIGHT
from reportlab.platypus import Table, TableStyle
from reportlab.lib import colors
from reportlab.platypus import Frame, PageTemplate
from reportlab.lib.utils import ImageReader
import os

def create_high_quality_proposal_pdf():
    """Generate a high-quality CodeFlow Studios proposal PDF"""
    
    # Create PDF document with proper margins
    filename = "/Users/tayyab/Desktop/flick/CodeFlow_Studios_Proposal_HQ.pdf"
    doc = SimpleDocTemplate(
        filename, 
        pagesize=A4,
        rightMargin=1*inch, 
        leftMargin=1*inch, 
        topMargin=1*inch, 
        bottomMargin=1*inch
    )
    
    # Container for the 'Flowable' objects
    story = []
    
    # Get default styles
    styles = getSampleStyleSheet()
    
    # Define custom colors
    primary_blue = HexColor('#667eea')
    secondary_blue = HexColor('#764ba2')
    accent_red = HexColor('#ff6b6b')
    success_green = HexColor('#4ecdc4')
    dark_gray = HexColor('#2c3e50')
    light_gray = HexColor('#f8f9fa')
    text_gray = HexColor('#333333')
    
    # Create custom styles
    title_style = ParagraphStyle(
        'CustomTitle',
        parent=styles['Heading1'],
        fontSize=32,
        spaceAfter=20,
        alignment=TA_CENTER,
        textColor=primary_blue,
        fontName='Helvetica-Bold',
        leading=40
    )
    
    subtitle_style = ParagraphStyle(
        'CustomSubtitle',
        parent=styles['Heading2'],
        fontSize=20,
        spaceAfter=25,
        alignment=TA_CENTER,
        textColor=dark_gray,
        fontName='Helvetica-Bold',
        leading=24
    )
    
    section_style = ParagraphStyle(
        'CustomSection',
        parent=styles['Heading2'],
        fontSize=18,
        spaceAfter=15,
        alignment=TA_LEFT,
        textColor=primary_blue,
        fontName='Helvetica-Bold',
        leading=22,
        leftIndent=0
    )
    
    subsection_style = ParagraphStyle(
        'CustomSubsection',
        parent=styles['Heading3'],
        fontSize=14,
        spaceAfter=10,
        alignment=TA_LEFT,
        textColor=dark_gray,
        fontName='Helvetica-Bold',
        leading=18
    )
    
    highlight_style = ParagraphStyle(
        'Highlight',
        parent=styles['Normal'],
        fontSize=16,
        spaceAfter=12,
        alignment=TA_CENTER,
        textColor=colors.white,
        fontName='Helvetica-Bold',
        backColor=accent_red,
        borderPadding=15,
        leading=20
    )
    
    price_style = ParagraphStyle(
        'PriceStyle',
        parent=styles['Normal'],
        fontSize=24,
        spaceAfter=8,
        alignment=TA_CENTER,
        textColor=colors.white,
        fontName='Helvetica-Bold',
        leading=30
    )
    
    normal_style = ParagraphStyle(
        'CustomNormal',
        parent=styles['Normal'],
        fontSize=11,
        spaceAfter=8,
        alignment=TA_JUSTIFY,
        textColor=text_gray,
        fontName='Helvetica',
        leading=14
    )
    
    bullet_style = ParagraphStyle(
        'BulletStyle',
        parent=styles['Normal'],
        fontSize=11,
        spaceAfter=6,
        alignment=TA_LEFT,
        textColor=text_gray,
        fontName='Helvetica',
        leftIndent=20,
        leading=14
    )
    
    # Title Page
    story.append(Spacer(1, 0.5*inch))
    story.append(Paragraph("🚀 CodeFlow Studios", title_style))
    story.append(Paragraph("Professional Development Proposal", subtitle_style))
    story.append(Spacer(1, 0.3*inch))
    
    # Exclusive Offer Box
    offer_data = [
        ['⚡ EXCLUSIVE OFFER - LIMITED TIME'],
        ['💰 DISCOUNTED PRICE: $13,500'],
        ['Regular Price: $18,000 - Save $4,500!']
    ]
    
    offer_table = Table(offer_data, colWidths=[6*inch])
    offer_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('BACKGROUND', (0, 1), (-1, 1), accent_red),
        ('BACKGROUND', (0, 2), (-1, 2), light_gray),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('TEXTCOLOR', (0, 1), (-1, 1), colors.white),
        ('TEXTCOLOR', (0, 2), (-1, 2), text_gray),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTNAME', (0, 1), (-1, 1), 'Helvetica-Bold'),
        ('FONTNAME', (0, 2), (-1, 2), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, 0), 14),
        ('FONTSIZE', (0, 1), (-1, 1), 18),
        ('FONTSIZE', (0, 2), (-1, 2), 12),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 15),
        ('TOPPADDING', (0, 0), (-1, -1), 15),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
    ]))
    
    story.append(offer_table)
    story.append(Spacer(1, 0.4*inch))
    
    # About Section
    story.append(Paragraph("🏢 About CodeFlow Studios", section_style))
    story.append(Paragraph(
        "CodeFlow Studios is a premier software development company specializing in creating cutting-edge digital solutions that drive business growth and innovation. Based on our proven track record and expertise, we're excited to present this exclusive proposal for your project.",
        normal_style
    ))
    story.append(Spacer(1, 0.2*inch))
    
    # Core Strengths
    story.append(Paragraph("🎯 Our Core Strengths", section_style))
    strengths = [
        "🔧 Full-Stack Development - End-to-end solution delivery",
        "⚡ Modern Technology Stack - Latest frameworks and best practices", 
        "🔄 Agile Methodology - Rapid, iterative development process",
        "🛡️ Quality Assurance - Comprehensive testing and code review",
        "🕐 24/7 Support - Round-the-clock technical assistance",
        "📈 Scalable Architecture - Future-proof solutions that grow with your business"
    ]
    
    for strength in strengths:
        story.append(Paragraph(strength, bullet_style))
    
    story.append(PageBreak())
    
    # Project Scope
    story.append(Paragraph("📋 Project Scope & Deliverables", section_style))
    story.append(Paragraph("🎯 MVP Development Package", subsection_style))
    story.append(Paragraph("Our comprehensive development package includes:", normal_style))
    story.append(Spacer(1, 0.15*inch))
    
    # Create a nice layout for deliverables
    deliverables_data = [
        ['🎨 Frontend Development', '⚙️ Backend Development'],
        ['• Responsive web application design', '• RESTful API development'],
        ['• Modern UI/UX implementation', '• Database design and implementation'],
        ['• Cross-browser compatibility', '• Authentication & authorization'],
        ['• Mobile-first approach', '• Data validation and security'],
        ['• Progressive Web App (PWA) capabilities', '• Performance optimization'],
        ['', ''],
        ['🚀 DevOps & Deployment', '📚 Additional Services'],
        ['• Cloud infrastructure setup', '• Project documentation'],
        ['• CI/CD pipeline implementation', '• User training materials'],
        ['• Automated testing integration', '• 3 months post-launch support'],
        ['• Production deployment', '• Performance optimization'],
        ['• Monitoring and analytics setup', '• Security audit']
    ]
    
    deliverables_table = Table(deliverables_data, colWidths=[3*inch, 3*inch])
    deliverables_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('BACKGROUND', (0, 7), (-1, 7), success_green),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('TEXTCOLOR', (0, 7), (-1, 7), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTNAME', (0, 7), (-1, 7), 'Helvetica-Bold'),
        ('FONTNAME', (0, 1), (-1, 6), 'Helvetica'),
        ('FONTNAME', (0, 8), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, 0), 12),
        ('FONTSIZE', (0, 7), (-1, 7), 12),
        ('FONTSIZE', (0, 1), (-1, 6), 10),
        ('FONTSIZE', (0, 8), (-1, -1), 10),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ('TOPPADDING', (0, 0), (-1, -1), 8),
        ('LEFTPADDING', (0, 0), (-1, -1), 10),
        ('RIGHTPADDING', (0, 0), (-1, -1), 10),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, 6), [colors.white, light_gray]),
        ('ROWBACKGROUNDS', (0, 8), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(deliverables_table)
    story.append(PageBreak())
    
    # Technology Stack
    story.append(Paragraph("🛠️ Technology Stack", section_style))
    
    # Technology sections
    tech_sections = [
        ("🎨 Frontend Technologies", [
            "React.js - Modern, component-based UI development",
            "TypeScript - Type-safe development",
            "Tailwind CSS - Utility-first styling",
            "Next.js - Full-stack React framework"
        ]),
        ("⚙️ Backend Technologies", [
            "Node.js - Scalable server-side development",
            "Express.js - Fast, unopinionated web framework", 
            "PostgreSQL/MongoDB - Robust database solutions",
            "JWT Authentication - Secure user management"
        ]),
        ("☁️ DevOps & Cloud", [
            "AWS/DigitalOcean - Reliable cloud infrastructure",
            "Docker - Containerized deployment",
            "GitHub Actions - Automated CI/CD",
            "Nginx - High-performance web server"
        ])
    ]
    
    for title, items in tech_sections:
        story.append(Paragraph(title, subsection_style))
        for item in items:
            story.append(Paragraph(f"• {item}", bullet_style))
        story.append(Spacer(1, 0.1*inch))
    
    story.append(PageBreak())
    
    # Development Timeline
    story.append(Paragraph("⏰ Development Timeline", section_style))
    
    timeline_data = [
        ['Phase', 'Duration', 'Description'],
        ['Phase 1', 'Week 1-2', 'Planning & Design\n• Requirements analysis\n• UI/UX wireframing\n• Technical architecture planning\n• Project setup and environment configuration'],
        ['Phase 2', 'Week 3-8', 'Core Development\n• Frontend development\n• Backend API development\n• Database implementation\n• Integration testing'],
        ['Phase 3', 'Week 9-10', 'Testing & Optimization\n• Comprehensive testing\n• Performance optimization\n• Security audit\n• Bug fixes and refinements'],
        ['Phase 4', 'Week 11-12', 'Deployment & Launch\n• Production deployment\n• Final testing\n• Documentation completion\n• Launch support']
    ]
    
    timeline_table = Table(timeline_data, colWidths=[1.2*inch, 1.2*inch, 4.6*inch])
    timeline_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('ALIGN', (1, 0), (1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTNAME', (0, 1), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, 0), 12),
        ('FONTSIZE', (0, 1), (-1, -1), 10),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 12),
        ('TOPPADDING', (0, 0), (-1, -1), 12),
        ('LEFTPADDING', (0, 0), (-1, -1), 10),
        ('RIGHTPADDING', (0, 0), (-1, -1), 10),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'TOP')
    ]))
    
    story.append(timeline_table)
    story.append(Spacer(1, 0.3*inch))
    
    # Investment & Payment Structure
    story.append(Paragraph("💰 Investment & Payment Structure", section_style))
    
    # Price highlight box
    price_data = [
        ['🎯 Total Project Cost: $13,500'],
        ['SAVE $4,500! (Regular Price: $18,000)']
    ]
    
    price_table = Table(price_data, colWidths=[6*inch])
    price_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), accent_red),
        ('BACKGROUND', (0, 1), (-1, 1), light_gray),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('TEXTCOLOR', (0, 1), (-1, 1), text_gray),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTNAME', (0, 1), (-1, 1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, 0), 16),
        ('FONTSIZE', (0, 1), (-1, 1), 12),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 15),
        ('TOPPADDING', (0, 0), (-1, -1), 15),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
    ]))
    
    story.append(price_table)
    story.append(Spacer(1, 0.2*inch))
    
    # Payment Schedule
    story.append(Paragraph("💳 Payment Schedule", subsection_style))
    payment_data = [
        ['Payment Type', 'Percentage', 'Amount', 'Trigger'],
        ['Initial Payment', '40%', '$5,400', 'Project kickoff'],
        ['Mid-Project', '40%', '$5,400', 'Core development completion'],
        ['Final Payment', '20%', '$2,700', 'Project delivery']
    ]
    
    payment_table = Table(payment_data, colWidths=[2*inch, 1*inch, 1.5*inch, 2.5*inch])
    payment_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), success_green),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('ALIGN', (1, 0), (1, -1), 'CENTER'),
        ('ALIGN', (2, 0), (2, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTNAME', (0, 1), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, 0), 12),
        ('FONTSIZE', (0, 1), (-1, -1), 10),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 12),
        ('TOPPADDING', (0, 0), (-1, -1), 12),
        ('LEFTPADDING', (0, 0), (-1, -1), 10),
        ('RIGHTPADDING', (0, 0), (-1, -1), 10),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, light_gray]),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE')
    ]))
    
    story.append(payment_table)
    story.append(Spacer(1, 0.2*inch))
    
    # What's Included
    story.append(Paragraph("🎁 What's Included", subsection_style))
    included_items = [
        "✅ Complete MVP development",
        "✅ 3 months post-launch support", 
        "✅ All source code and documentation",
        "✅ Training and handover sessions",
        "✅ Future scalability considerations"
    ]
    
    for item in included_items:
        story.append(Paragraph(item, bullet_style))
    
    story.append(PageBreak())
    
    # Why Choose CodeFlow Studios
    story.append(Paragraph("🌟 Why Choose CodeFlow Studios?", section_style))
    
    reasons = [
        ("🏆 Proven Expertise", [
            "5+ years of development experience",
            "50+ successful projects delivered", 
            "98% client satisfaction rate",
            "Modern technology expertise"
        ]),
        ("🔒 Quality Assurance", [
            "Code review and testing protocols",
            "Security best practices implementation",
            "Performance optimization",
            "Cross-platform compatibility"
        ]),
        ("🚀 Rapid Delivery", [
            "Agile development methodology",
            "Weekly progress reports",
            "Regular client communication",
            "Fast iteration cycles"
        ]),
        ("💡 Innovation Focus", [
            "Latest technology adoption",
            "Scalable architecture design",
            "Future-proof solutions",
            "Continuous improvement mindset"
        ])
    ]
    
    for title, items in reasons:
        story.append(Paragraph(title, subsection_style))
        for item in items:
            story.append(Paragraph(f"• {item}", bullet_style))
        story.append(Spacer(1, 0.1*inch))
    
    story.append(Spacer(1, 0.2*inch))
    
    # Next Steps
    story.append(Paragraph("🚀 Next Steps", section_style))
    story.append(Paragraph("Ready to Get Started?", subsection_style))
    
    steps = [
        "1. 📞 Schedule a Discovery Call - Let's discuss your specific requirements",
        "2. ✍️ Sign the Agreement - Secure your discounted pricing",
        "3. 🎯 Project Kickoff - Begin development immediately"
    ]
    
    for step in steps:
        story.append(Paragraph(step, bullet_style))
    
    story.append(Spacer(1, 0.2*inch))
    
    # Contact Information
    story.append(Paragraph("📞 Contact Information", subsection_style))
    contact_info = [
        "🌐 Website: https://www.codeflowstudios.xyz/",
        "📱 WhatsApp: +92-333-4443355"
    ]
    
    for info in contact_info:
        story.append(Paragraph(info, bullet_style))
    
    story.append(Spacer(1, 0.2*inch))
    
    # Terms & Conditions
    story.append(Paragraph("📋 Terms & Conditions", section_style))
    story.append(Paragraph("Project Terms:", subsection_style))
    
    project_terms = [
        "⏰ Timeline: 12 weeks from project start",
        "🛠️ Support: 3 months post-launch included",
        "🔄 Revisions: Up to 3 major revision rounds",
        "📜 Ownership: Full code ownership transferred upon final payment"
    ]
    
    for term in project_terms:
        story.append(Paragraph(term, bullet_style))
    
    story.append(Spacer(1, 0.1*inch))
    
    story.append(Paragraph("Payment Terms:", subsection_style))
    payment_terms = [
        "💰 Net 30 payment terms",
        "💳 Accept all major payment methods",
        "⏰ 50% discount valid for 30 days from proposal date"
    ]
    
    for term in payment_terms:
        story.append(Paragraph(term, bullet_style))
    
    story.append(Spacer(1, 0.3*inch))
    
    # Limited Time Offer
    story.append(Paragraph("⚡ Limited Time Offer", highlight_style))
    story.append(Paragraph(
        "This $4,500 discount is available for a limited time only. Secure your spot today to lock in this exclusive pricing and fast-track your project to success.",
        normal_style
    ))
    story.append(Spacer(1, 0.2*inch))
    story.append(Paragraph("Ready to transform your vision into reality?", subsection_style))
    story.append(Paragraph("Let CodeFlow Studios be your partner in digital innovation.", normal_style))
    
    story.append(Spacer(1, 0.3*inch))
    story.append(Paragraph("© 2025 CodeFlow Studios. All rights reserved.", ParagraphStyle(
        'Footer',
        parent=styles['Normal'],
        fontSize=9,
        alignment=TA_CENTER,
        textColor=dark_gray,
        fontName='Helvetica'
    )))
    
    # Build PDF
    doc.build(story)
    print(f"✅ High-quality PDF generated successfully: {filename}")
    return filename

if __name__ == "__main__":
    create_high_quality_proposal_pdf()
