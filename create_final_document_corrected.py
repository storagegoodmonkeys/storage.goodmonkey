#!/usr/bin/env python3
"""
Create the final document with corrected PyPDF2 syntax
"""

import PyPDF2
import os

def create_final_document():
    """Create the final document with updated annexures"""
    
    # File paths
    original_agreement = "/Users/tayyab/Desktop/flick/FINAL_GoodMonkeys_CodeFlowStudios_Agreement_with_Annexes (2).pdf"
    updated_annex1 = "/Users/tayyab/Desktop/flick/Final_Updated_Annex1.pdf"
    updated_annex2 = "/Users/tayyab/Desktop/flick/Final_Updated_Annex2.pdf"
    final_output = "/Users/tayyab/Desktop/flick/FINAL_SIGNED_GoodMonkeys_CodeFlowStudios_Agreement_UPDATED.pdf"
    
    # Check if files exist
    if not os.path.exists(original_agreement):
        print(f"❌ Original agreement not found: {original_agreement}")
        return None
    
    if not os.path.exists(updated_annex1):
        print(f"❌ Updated Annex 1 not found: {updated_annex1}")
        return None
        
    if not os.path.exists(updated_annex2):
        print(f"❌ Updated Annex 2 not found: {updated_annex2}")
        return None
    
    try:
        # Create PDF merger
        pdf_merger = PyPDF2.PdfMerger()
        
        # Add original agreement pages (first 6 pages only - the main agreement)
        print("📄 Reading original agreement...")
        with open(original_agreement, 'rb') as file:
            original_reader = PyPDF2.PdfReader(file)
            total_pages = len(original_reader.pages)
            print(f"📄 Original agreement has {total_pages} pages")
            
            # Add only the first 6 pages (main agreement without old annexures)
            for i in range(min(6, total_pages)):
                pdf_merger.append(original_reader.pages[i])
                print(f"📄 Added page {i+1} from original agreement")
        
        # Add updated Annex 1 using the correct syntax
        print("📄 Adding Updated Annex 1...")
        pdf_merger.append(updated_annex1)
        
        # Add updated Annex 2 using the correct syntax
        print("📄 Adding Updated Annex 2...")
        pdf_merger.append(updated_annex2)
        
        # Write merged PDF
        print("📄 Creating final merged document...")
        with open(final_output, 'wb') as output_file:
            pdf_merger.write(output_file)
        
        pdf_merger.close()
        
        print(f"✅ Final updated agreement created successfully!")
        print(f"📄 Final document: {final_output}")
        return final_output
        
    except Exception as e:
        print(f"❌ Error merging PDFs: {e}")
        return None


if __name__ == "__main__":
    print("Creating final document with updated annexures...")
    final_doc = create_final_document()
    
    if final_doc:
        print(f"\n✅ Final updated agreement created successfully!")
        print(f"📄 Final document: {final_doc}")
        print(f"🚀 Ready for signing!")
    else:
        print("\n❌ Error creating final document")


