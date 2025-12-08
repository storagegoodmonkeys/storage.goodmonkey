# 📸 Adding Logo Assets to Xcode

## Steps to Add Logos

1. **Open Xcode Project**
   - Open `Flick app IOS.xcodeproj` in Xcode

2. **Add Images to Assets**
   - In Xcode, click on `Assets.xcassets` in the project navigator
   - Right-click in the asset catalog → New Image Set
   - Name it: `Flick_Icon`
   - Drag `Flick_Icon.png` from Finder into the 1x, 2x, and 3x slots
   
   - Repeat for the logotype:
     - New Image Set → Name: `Logotype`
     - Drag `Logotype.png` into the slots

3. **Alternative Method**
   - Select the `Assets` folder in Finder
   - Drag both images directly into `Assets.xcassets` in Xcode
   - Xcode will automatically create image sets

## Files to Add:
- `Flick_Icon.png` → Image Set: `Flick_Icon`
- `Logotype.png` → Image Set: `Logotype`

After adding, the images will be available in SwiftUI as:
- `Image("Flick_Icon")`
- `Image("Logotype")`


