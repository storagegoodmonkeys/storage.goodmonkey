#!/bin/bash

# Script to get Supabase credentials
# Uses Supabase API to fetch project details

PROJECT_ID="kjhhwrvduqxprweqxhbo"
EMAIL="storage.goodmonkeys@gmail.com"
PASSWORD="GOODmonkeysLLC@101"

echo "🔍 Fetching Supabase credentials for project: $PROJECT_ID"
echo ""

# Construct Supabase URL
SUPABASE_URL="https://${PROJECT_ID}.supabase.co"

echo "✅ Supabase Project URL: $SUPABASE_URL"
echo ""
echo "📝 To get your anon key:"
echo "1. Go to: https://supabase.com/dashboard/project/$PROJECT_ID/settings/api"
echo "2. Copy the 'anon public' key"
echo ""
echo "Or login and we can fetch it programmatically..."

