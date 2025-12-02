#!/usr/bin/env python3
"""
PDF Generator for CodeFlow Studios Proposal
Converts the markdown proposal to a professional PDF with styling
"""

from reportlab.lib.pagesizes import letter, A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.lib.colors import Color, HexColor
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak
from reportlab.lib.enums import TA_CENTER, TA_LEFT, TA_JUSTIFY
from reportlab.platypus import Table, TableStyle
from reportlab.lib import colors
from reportlab.platypus import Image
import os

def create_proposal_pdf():
    """Generate the CodeFlow Studios proposal PDF"""
    
    # Create PDF document
    filename = "/Users/tayyab/Desktop/flick/CodeFlow_Studios_Proposal.pdf"
    doc = SimpleDocTemplate(filename, pagesize=A4, 
                          rightMargin=72, leftMargin=72, 
                          topMargin=72, bottomMargin=18)
    
    # Container for the 'Flowable' objects
    story = []
    
    # Get default styles
    styles = getSampleStyleSheet()
    
    # Define custom colors
    primary_blue = HexColor('#667eea')
    accent_red = HexColor('#ff6b6b')
    success_green = HexColor('#4ecdc4')
    dark_gray = HexColor('#2c3e50')
    
    # Create custom styles
    title_style = ParagraphStyle(
        'CustomTitle',
        parent=styles['Heading1'],
        fontSize=28,
        spaceAfter=30,
        alignment=TA_CENTER,
        textColor=primary_blue,
        fontName='Helvetica-Bold'
    )
    
    subtitle_style = ParagraphStyle(
        'CustomSubtitle',
        parent=styles['Heading2'],
        fontSize=18,
        spaceAfter=20,
        alignment=TA_CENTER,
        textColor=dark_gray,
        fontName='Helvetica-Bold'
    )
    
    section_style = ParagraphStyle(
        'CustomSection',
        parent=styles['Heading2'],
        fontSize=16,
        spaceAfter=15,
        alignment=TA_LEFT,
        textColor=primary_blue,
        fontName='Helvetica-Bold'
    )
    
    highlight_style = ParagraphStyle(
        'Highlight',
        parent=styles['Normal'],
        fontSize=14,
        spaceAfter=10,
        alignment=TA_CENTER,
        textColor=colors.white,
        fontName='Helvetica-Bold',
        backColor=accent_red
    )
    
    normal_style = ParagraphStyle(
        'CustomNormal',
        parent=styles['Normal'],
        fontSize=11,
        spaceAfter=8,
        alignment=TA_JUSTIFY,
        textColor=HexColor('#333333'),
        fontName='Helvetica'
    )
    
    # Title Page
    story.append(Paragraph("🚀 CodeFlow Studios", title_style))
    story.append(Paragraph("Professional Development Proposal", subtitle_style))
    story.append(Spacer(1, 20))
    
    # Exclusive Offer
    story.append(Paragraph("⚡ EXCLUSIVE OFFER - LIMITED TIME", highlight_style))
    story.append(Spacer(1, 10))
    story.append(Paragraph("💰 DISCOUNTED PRICE: $13,500", highlight_style))
    story.append(Paragraph("Regular Price: $18,000 - Save $4,500!", normal_style))
    story.append(Spacer(1, 30))
    
    # About Section
    story.append(Paragraph("🏢 About CodeFlow Studios", section_style))
    story.append(Paragraph(
        "CodeFlow Studios is a premier software development company specializing in creating cutting-edge digital solutions that drive business growth and innovation. Based on our proven track record and expertise, we're excited to present this exclusive proposal for your project.",
        normal_style
    ))
    story.append(Spacer(1, 15))
    
    # Core Strengths
    story.append(Paragraph("🎯 Our Core Strengths:", section_style))
    strengths = [
        "🔧 Full-Stack Development - End-to-end solution delivery",
        "⚡ Modern Technology Stack - Latest frameworks and best practices",
        "🔄 Agile Methodology - Rapid, iterative development process",
        "🛡️ Quality Assurance - Comprehensive testing and code review",
        "🕐 24/7 Support - Round-the-clock technical assistance",
        "📈 Scalable Architecture - Future-proof solutions that grow with your business"
    ]
    
    for strength in strengths:
        story.append(Paragraph(strength, normal_style))
    
    story.append(PageBreak())
    
    # Project Scope
    story.append(Paragraph("📋 Project Scope & Deliverables", section_style))
    story.append(Paragraph("🎯 MVP Development Package", subtitle_style))
    story.append(Paragraph("Our comprehensive development package includes:", normal_style))
    story.append(Spacer(1, 15))
    
    # Frontend Development
    story.append(Paragraph("🎨 Frontend Development", section_style))
    frontend_items = [
        "✅ Responsive web application design",
        "✅ Modern UI/UX implementation",
        "✅ Cross-browser compatibility",
        "✅ Mobile-first approach",
        "✅ Progressive Web App (PWA) capabilities"
    ]
    for item in frontend_items:
        story.append(Paragraph(item, normal_style))
    
    story.append(Spacer(1, 15))
    
    # Backend Development
    story.append(Paragraph("⚙️ Backend Development", section_style))
    backend_items = [
        "✅ RESTful API development",
        "✅ Database design and implementation",
        "✅ Authentication & authorization",
        "✅ Data validation and security",
        "✅ Performance optimization"
    ]
    for item in backend_items:
        story.append(Paragraph(item, normal_style))
    
    story.append(Spacer(1, 15))
    
    # DevOps & Deployment
    story.append(Paragraph("🚀 DevOps & Deployment", section_style))
    devops_items = [
        "✅ Cloud infrastructure setup",
        "✅ CI/CD pipeline implementation",
        "✅ Automated testing integration",
        "✅ Production deployment",
        "✅ Monitoring and analytics setup"
    ]
    for item in devops_items:
        story.append(Paragraph(item, normal_style))
    
    story.append(Spacer(1, 15))
    
    # Additional Services
    story.append(Paragraph("📚 Additional Services", section_style))
    additional_items = [
        "✅ Project documentation",
        "✅ User training materials",
        "✅ 3 months post-launch support",
        "✅ Performance optimization",
        "✅ Security audit"
    ]
    for item in additional_items:
        story.append(Paragraph(item, normal_style))
    
    story.append(PageBreak())
    
    # Technology Stack
    story.append(Paragraph("🛠️ Technology Stack", section_style))
    
    # Frontend Technologies
    story.append(Paragraph("🎨 Frontend Technologies", subtitle_style))
    frontend_tech = [
        "React.js - Modern, component-based UI development",
        "TypeScript - Type-safe development",
        "Tailwind CSS - Utility-first styling",
        "Next.js - Full-stack React framework"
    ]
    for tech in frontend_tech:
        story.append(Paragraph(tech, normal_style))
    
    story.append(Spacer(1, 15))
    
    # Backend Technologies
    story.append(Paragraph("⚙️ Backend Technologies", subtitle_style))
    backend_tech = [
        "Node.js - Scalable server-side development",
        "Express.js - Fast, unopinionated web framework",
        "PostgreSQL/MongoDB - Robust database solutions",
        "JWT Authentication - Secure user management"
    ]
    for tech in backend_tech:
        story.append(Paragraph(tech, normal_style))
    
    story.append(Spacer(1, 15))
    
    # DevOps & Cloud
    story.append(Paragraph("☁️ DevOps & Cloud", subtitle_style))
    devops_tech = [
        "AWS/DigitalOcean - Reliable cloud infrastructure",
        "Docker - Containerized deployment",
        "GitHub Actions - Automated CI/CD",
        "Nginx - High-performance web server"
    ]
    for tech in devops_tech:
        story.append(Paragraph(tech, normal_style))
    
    story.append(PageBreak())
    
    # Development Timeline
    story.append(Paragraph("⏰ Development Timeline", section_style))
    
    timeline_data = [
        ['Phase', 'Duration', 'Description'],
        ['Phase 1', 'Week 1-2', 'Planning & Design - Requirements analysis, UI/UX wireframing, Technical architecture planning, Project setup'],
        ['Phase 2', 'Week 3-8', 'Core Development - Frontend development, Backend API development, Database implementation, Integration testing'],
        ['Phase 3', 'Week 9-10', 'Testing & Optimization - Comprehensive testing, Performance optimization, Security audit, Bug fixes'],
        ['Phase 4', 'Week 11-12', 'Deployment & Launch - Production deployment, Final testing, Documentation completion, Launch support']
    ]
    
    timeline_table = Table(timeline_data, colWidths=[1*inch, 1*inch, 4*inch])
    timeline_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), primary_blue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 12),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, 1), (-1, -1), colors.white),
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
        ('FONTSIZE', (0, 1), (-1, -1), 10),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, HexColor('#f8f9fa')])
    ]))
    
    story.append(timeline_table)
    story.append(Spacer(1, 30))
    
    # Investment & Payment Structure
    story.append(Paragraph("💰 Investment & Payment Structure", section_style))
    story.append(Paragraph("🎯 Total Project Cost: $13,500", highlight_style))
    story.append(Paragraph("SAVE $4,500! (Regular Price: $18,000)", normal_style))
    story.append(Spacer(1, 20))
    
    # Payment Schedule
    story.append(Paragraph("💳 Payment Schedule:", subtitle_style))
    payment_data = [
        ['Payment', 'Percentage', 'Amount', 'Trigger'],
        ['Initial Payment', '40%', '$5,400', 'Project kickoff'],
        ['Mid-Project', '40%', '$5,400', 'Core development completion'],
        ['Final Payment', '20%', '$2,700', 'Project delivery']
    ]
    
    payment_table = Table(payment_data, colWidths=[1.5*inch, 1*inch, 1*inch, 2.5*inch])
    payment_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), success_green),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 12),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, 1), (-1, -1), colors.white),
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
        ('FONTSIZE', (0, 1), (-1, -1), 10),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, HexColor('#f8f9fa')])
    ]))
    
    story.append(payment_table)
    story.append(Spacer(1, 20))
    
    # What's Included
    story.append(Paragraph("🎁 What's Included:", subtitle_style))
    included_items = [
        "✅ Complete MVP development",
        "✅ 3 months post-launch support",
        "✅ All source code and documentation",
        "✅ Training and handover sessions",
        "✅ Future scalability considerations"
    ]
    for item in included_items:
        story.append(Paragraph(item, normal_style))
    
    story.append(PageBreak())
    
    # Why Choose CodeFlow Studios
    story.append(Paragraph("🌟 Why Choose CodeFlow Studios?", section_style))
    
    reasons = [
        ("🏆 Proven Expertise", "5+ years of development experience, 50+ successful projects delivered, 98% client satisfaction rate, Modern technology expertise"),
        ("🔒 Quality Assurance", "Code review and testing protocols, Security best practices implementation, Performance optimization, Cross-platform compatibility"),
        ("🚀 Rapid Delivery", "Agile development methodology, Weekly progress reports, Regular client communication, Fast iteration cycles"),
        ("💡 Innovation Focus", "Latest technology adoption, Scalable architecture design, Future-proof solutions, Continuous improvement mindset")
    ]
    
    for title, description in reasons:
        story.append(Paragraph(title, subtitle_style))
        story.append(Paragraph(description, normal_style))
        story.append(Spacer(1, 15))
    
    # Next Steps
    story.append(Paragraph("🚀 Next Steps", section_style))
    story.append(Paragraph("Ready to Get Started?", subtitle_style))
    
    steps = [
        "1. 📞 Schedule a Discovery Call - Let's discuss your specific requirements",
        "2. ✍️ Sign the Agreement - Secure your discounted pricing",
        "3. 🎯 Project Kickoff - Begin development immediately"
    ]
    
    for step in steps:
        story.append(Paragraph(step, normal_style))
    
    story.append(Spacer(1, 20))
    
    # Contact Information
    story.append(Paragraph("📞 Contact Information", subtitle_style))
    contact_info = [
        "🌐 Website: https://www.codeflowstudios.xyz/",
        "📧 Email: info@codeflowstudios.xyz",
        "📱 Phone: [Your Contact Number]"
    ]
    
    for info in contact_info:
        story.append(Paragraph(info, normal_style))
    
    story.append(Spacer(1, 20))
    
    # Terms & Conditions
    story.append(Paragraph("📋 Terms & Conditions", section_style))
    story.append(Paragraph("Project Terms:", subtitle_style))
    
    project_terms = [
        "⏰ Timeline: 12 weeks from project start",
        "🛠️ Support: 3 months post-launch included",
        "🔄 Revisions: Up to 3 major revision rounds",
        "📜 Ownership: Full code ownership transferred upon final payment"
    ]
    
    for term in project_terms:
        story.append(Paragraph(term, normal_style))
    
    story.append(Spacer(1, 15))
    
    story.append(Paragraph("Payment Terms:", subtitle_style))
    payment_terms = [
        "💰 Net 30 payment terms",
        "💳 Accept all major payment methods",
        "⏰ 50% discount valid for 30 days from proposal date"
    ]
    
    for term in payment_terms:
        story.append(Paragraph(term, normal_style))
    
    story.append(Spacer(1, 20))
    
    # Limited Time Offer
    story.append(Paragraph("⚡ Limited Time Offer", highlight_style))
    story.append(Paragraph(
        "This $4,500 discount is available for a limited time only. Secure your spot today to lock in this exclusive pricing and fast-track your project to success.",
        normal_style
    ))
    story.append(Spacer(1, 15))
    story.append(Paragraph("Ready to transform your vision into reality?", subtitle_style))
    story.append(Paragraph("Let CodeFlow Studios be your partner in digital innovation.", normal_style))
    
    story.append(Spacer(1, 30))
    story.append(Paragraph("© 2024 CodeFlow Studios. All rights reserved.", ParagraphStyle(
        'Footer',
        parent=styles['Normal'],
        fontSize=9,
        alignment=TA_CENTER,
        textColor=dark_gray,
        fontName='Helvetica'
    )))
    
    # Build PDF
    doc.build(story)
    print(f"✅ PDF generated successfully: {filename}")
    return filename

if __name__ == "__main__":
    create_proposal_pdf()






