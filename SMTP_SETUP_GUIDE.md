# SMTP Setup for Supabase - Do You Need It?

## Quick Answer: **No, you don't need SMTP for basic email verification**

Supabase has built-in email sending that works without SMTP configuration.

---

## When You DON'T Need SMTP:

✅ **Basic email verification** - Works out of the box  
✅ **OTP codes** - Works with default email service  
✅ **Password resets** - Works automatically  
✅ **Testing the app** - No SMTP needed

---

## When You SHOULD Set Up SMTP:

1. **Emails going to spam** - Custom SMTP improves deliverability
2. **Custom "From" address** - Want emails from `noreply@yourdomain.com` instead of `noreply@mail.app.supabase.io`
3. **High email volume** - Better rate limits
4. **Production app** - More professional email setup
5. **Emails not arriving** - If default service is blocked by email providers

---

## How to Set Up SMTP (If Needed)

### Option 1: Gmail SMTP (Easy for Testing)

1. Go to: **Supabase Dashboard → Settings → Auth → SMTP Settings**
2. Enable **"Custom SMTP"**
3. Fill in:
   - **Host:** `smtp.gmail.com`
   - **Port:** `587`
   - **Username:** Your Gmail address
   - **Password:** App-specific password (see below)
   - **Sender Email:** Your Gmail address
   - **Sender Name:** Flick

4. **To get Gmail App Password:**
   - Go to Google Account settings
   - Security → 2-Step Verification (must be ON)
   - App passwords → Generate password for "Mail"
   - Use that password in Supabase

### Option 2: SendGrid (Production Recommended)

1. Sign up at sendgrid.com (free tier: 100 emails/day)
2. Create API key
3. In Supabase:
   - **Host:** `smtp.sendgrid.net`
   - **Port:** `587`
   - **Username:** `apikey`
   - **Password:** Your SendGrid API key
   - **Sender Email:** Verified sender email
   - **Sender Name:** Flick

### Option 3: Mailgun, Postmark, etc.

Similar process - get credentials from provider and enter in Supabase SMTP settings.

---

## For Now (Testing):

**Skip SMTP setup!** 

Just:
1. Disable email confirmation (for immediate testing)
2. OR use default Supabase email service (it works)

**Set up SMTP later** when you're ready for production or if emails aren't arriving.

---

## Check If Emails Are Working:

1. Sign up with a test email
2. Check inbox (and spam folder)
3. If emails arrive → No SMTP needed yet
4. If emails don't arrive → Set up SMTP

---

## My Recommendation:

**For testing:** Don't set up SMTP yet. Just disable email confirmation.

**For production:** Set up SendGrid or Gmail SMTP for better deliverability.



