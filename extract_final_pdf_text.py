#!/usr/bin/env python3
"""
Extract text from Final.pdf to understand its current content
"""

import PyPDF2

def extract_final_pdf_text():
    """Extract text from Final.pdf"""
    
    pdf_path = "/Users/tayyab/Desktop/flick/Final.pdf"
    
    try:
        with open(pdf_path, 'rb') as file:
            reader = PyPDF2.PdfReader(file)
            text = ""
            
            for page_num in range(len(reader.pages)):
                page = reader.pages[page_num]
                text += f"\n--- PAGE {page_num + 1} ---\n"
                text += page.extract_text()
                text += "\n"
            
            print("Final.pdf content extracted successfully!")
            print(f"Total pages: {len(reader.pages)}")
            print("\nContent preview:")
            print(text[:2000])  # Show first 2000 characters
            
            return text
            
    except Exception as e:
        print(f"Error extracting text: {e}")
        return None

if __name__ == "__main__":
    extract_final_pdf_text()


