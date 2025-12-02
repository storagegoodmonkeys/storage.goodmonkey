#!/usr/bin/env python3
"""
Add CodeFlow Studios signature details to the agreement
"""

from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4
from reportlab.lib.colors import HexColor
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
import PyPDF2
from PyPDF2 import PdfReader, PdfWriter
import io

def add_signature_to_agreement():
    """Add signature details to page 6 of the original agreement"""
    
    # Read the final merged document
    input_pdf = "/Users/tayyab/Desktop/flick/FINAL_GoodMonkeys_CodeFlowStudios_Agreement_with_Annexes.pdf"
    output_pdf = "/Users/tayyab/Desktop/flick/FINAL_SIGNED_GoodMonkeys_CodeFlowStudios_Agreement.pdf"
    
    # Read the existing PDF
    reader = PdfReader(input_pdf)
    writer = PdfWriter()
    
    # The signature section is on page 6 (index 5)
    signature_page_index = 5
    
    # Create overlay with signature details
    packet = io.BytesIO()
    can = canvas.Canvas(packet, pagesize=A4)
    
    # Define colors
    text_color = HexColor('#2c3e50')
    
    # Set font
    can.setFont("Helvetica", 11)
    can.setFillColor(text_color)
    
    # Position for CodeFlow Studios signature (right side)
    # These coordinates are approximate - may need adjustment based on original PDF layout
    x_start = 320  # Right side starting position
    y_start = 185  # Vertical position (from bottom)
    
    # Add signature directly on the signature line
    can.setFont("Helvetica-Oblique", 14)
    can.drawString(x_start, y_start + 25, "Saddam")
    
    # Add Name
    can.drawString(x_start, y_start, "Name: Saddam")
    
    # Add Title
    can.drawString(x_start, y_start - 20, "Title: Founder")
    
    # Add Location
    can.drawString(x_start, y_start - 40, "Location: Pakistan")
    
    # Add Date
    can.drawString(x_start, y_start - 60, "Date: 10.10.2025")
    
    can.save()
    
    # Move to the beginning of the BytesIO buffer
    packet.seek(0)
    overlay_pdf = PdfReader(packet)
    
    # Process all pages
    for i, page in enumerate(reader.pages):
        if i == signature_page_index:
            # Merge the overlay with the signature page
            page.merge_page(overlay_pdf.pages[0])
        writer.add_page(page)
    
    # Write output
    with open(output_pdf, 'wb') as output_file:
        writer.write(output_file)
    
    print(f"✅ Signature added successfully!")
    print(f"📄 Final signed document: {output_pdf}")
    return output_pdf

if __name__ == "__main__":
    add_signature_to_agreement()

