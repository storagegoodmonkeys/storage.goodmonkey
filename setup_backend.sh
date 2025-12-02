#!/bin/bash

# Flick App Backend Setup Script
# This script helps configure Supabase and GitHub

echo "🚀 Flick App Backend Setup"
echo "=========================="
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing Git repository..."
    git init
fi

# Setup GitHub remote
echo ""
echo "🔗 Setting up GitHub remote..."
GITHUB_URL="https://github.com/storagegoodmonkeys/storage.goodmonkey.git"
git remote remove origin 2>/dev/null
git remote add origin "$GITHUB_URL"
echo "✅ GitHub remote set to: $GITHUB_URL"

# Get Supabase credentials
echo ""
echo "📝 Supabase Configuration"
echo "Get your credentials from: https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/settings/api"
echo ""
read -p "Enter your Supabase Project URL (e.g., https://kjhhwrvduqxprweqxhbo.supabase.co): " SUPABASE_URL
read -p "Enter your Supabase anon/public key: " SUPABASE_KEY

# Update SupabaseService.swift
if [ ! -z "$SUPABASE_URL" ] && [ ! -z "$SUPABASE_KEY" ]; then
    echo ""
    echo "📝 Updating SupabaseService.swift..."
    
    SUPABASE_SERVICE_FILE="flick-ios/Flick app IOS/Flick app IOS/Services/SupabaseService.swift"
    
    if [ -f "$SUPABASE_SERVICE_FILE" ]; then
        # Use sed to replace the placeholders
        sed -i '' "s|YOUR_SUPABASE_URL|$SUPABASE_URL|g" "$SUPABASE_SERVICE_FILE"
        sed -i '' "s|YOUR_SUPABASE_ANON_KEY|$SUPABASE_KEY|g" "$SUPABASE_SERVICE_FILE"
        echo "✅ Supabase credentials updated in SupabaseService.swift"
    else
        echo "❌ SupabaseService.swift not found at: $SUPABASE_SERVICE_FILE"
    fi
fi

echo ""
echo "✨ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Go to Supabase SQL Editor and run supabase_schema.sql"
echo "2. Add Supabase Swift SDK to Xcode project"
echo "3. Build and test the app"

