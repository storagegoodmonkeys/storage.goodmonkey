#!/usr/bin/env python3
import PyPDF2

def extract_text_from_pdf(pdf_path):
    with open(pdf_path, 'rb') as file:
        pdf_reader = PyPDF2.PdfReader(file)
        text = ""
        for page in pdf_reader.pages:
            text += page.extract_text() + "\n\n"
    return text

# Extract from the V03 document
text = extract_text_from_pdf("/Users/tayyab/Desktop/flick/V03_GoodMonkeys_CodeFlowStudios_FlickApp_08.10.2025.pdf")
print(text)






