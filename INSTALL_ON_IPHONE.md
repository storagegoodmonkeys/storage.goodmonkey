# 📱 HOW TO INSTALL FLICK APP ON YOUR iPhone

## 🎯 Quick Guide

### Prerequisites ✅
1. **iPhone** connected to your Mac via USB cable
2. **Xcode** installed on your Mac
3. **Apple ID** signed in (free account works for testing)
4. **macOS** with developer tools

---

## 📝 STEP-BY-STEP INSTRUCTIONS

### STEP 1: Open Xcode Project
1. Navigate to: `/Users/tayyab/Desktop/flick/flick-ios/Flick app IOS/Flick app IOS/`
2. Double-click: **`Flick app IOS.xcodeproj`**
3. Wait for Xcode to load the project

---

### STEP 2: Configure Code Signing
1. In Xcode, click on **"Flick app IOS"** in the left sidebar (blue icon at the top)
2. Select the **"Flick app IOS"** target (under TARGETS)
3. Click the **"Signing & Capabilities"** tab
4. ✅ Check **"Automatically manage signing"**
5. In **Team** dropdown, select your Apple ID
   - If you don't see your Apple ID, click "Add Account..." and sign in
6. Xcode will automatically generate a **Bundle Identifier** (you may need to change it if there's a conflict)

**Note:** For free Apple Developer accounts, you might need to change the Bundle Identifier to something unique like: `com.yourname.flickapp`

---

### STEP 3: Connect Your iPhone
1. Connect your iPhone to your Mac using a **USB cable**
2. **Unlock your iPhone**
3. If prompted on iPhone: **"Trust This Computer?"** → Tap **"Trust"**
4. Enter your iPhone passcode if asked

---

### STEP 4: Select Your iPhone as Target Device
1. In Xcode's top toolbar, you'll see a device selector (shows "Any iPhone" or simulator name)
2. Click on it to see a dropdown
3. Select your **iPhone** from the list (it should show your iPhone name)
4. If you don't see your iPhone:
   - Make sure it's unlocked
   - Check if "Trust This Computer" dialog appeared
   - Try unplugging and replugging the cable

---

### STEP 5: Build and Install
1. Click the **Play (▶️) button** in Xcode's top left, OR
2. Press **`Cmd + R`** on your keyboard
3. Xcode will:
   - Build the app
   - Install it on your iPhone
   - Launch the app automatically

**First Time Only:**
- You'll see an error on iPhone: **"Untrusted Developer"**
- Go to: **Settings → General → VPN & Device Management** (or **Device Management**)
- Tap on your **Apple ID email**
- Tap **"Trust [Your Apple ID]"**
- Tap **"Trust"** again to confirm
- Go back and launch the app from home screen

---

## ✅ VERIFICATION

After installation:
1. ✅ App icon should appear on your iPhone home screen
2. ✅ App should launch automatically
3. ✅ You should see the onboarding/login screens
4. ✅ Test signup/signin to verify backend connection

---

## 🔧 TROUBLESHOOTING

### Issue: "No devices found"
- **Solution:** 
  - Unlock iPhone
  - Check USB cable connection
  - Trust computer on iPhone
  - Restart Xcode

### Issue: "Signing error" or "No signing certificate"
- **Solution:**
  - Make sure you're signed in with Apple ID in Xcode
  - Check "Automatically manage signing" is enabled
  - Try changing Bundle Identifier to something unique

### Issue: "Could not launch app" or "Untrusted Developer"
- **Solution:**
  - Go to iPhone: Settings → General → VPN & Device Management
  - Trust your Apple ID developer certificate
  - Launch app again from home screen

### Issue: App crashes on launch
- **Solution:**
  - Check Xcode console for errors
  - Make sure all dependencies are installed
  - Try cleaning build: Product → Clean Build Folder (Shift+Cmd+K)

---

## 📱 AFTER INSTALLATION

### Testing Checklist:
1. ✅ Sign Up with a real email
2. ✅ Check email for verification (if enabled)
3. ✅ Sign In
4. ✅ Add a lighter → Check Supabase dashboard to see it saved
5. ✅ Edit a lighter → Check Supabase dashboard for updates
6. ✅ Navigate through all screens
7. ✅ Test all buttons

---

## 🔗 VIEW YOUR DATA

After testing, view saved data:
**Supabase Dashboard:** https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo

Check tables:
- `users` - Your user account
- `lighters` - Lighters you added
- `trades` - Any trades created
- `lost_found` - Lost/found reports

---

## 📞 NEED HELP?

If you encounter any issues:
1. Check Xcode console for error messages
2. Check iPhone Settings → General → VPN & Device Management
3. Make sure iPhone is unlocked and trusted
4. Try cleaning build folder and rebuilding

**Ready to install! 🚀**

