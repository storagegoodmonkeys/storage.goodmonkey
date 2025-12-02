#!/bin/bash
echo "🔐 Supabase Credentials Setup"
echo "=============================="
echo ""
echo "Get your credentials from:"
echo "https://supabase.com/dashboard/project/kjhhwrvduqxprweqxhbo/settings/api"
echo ""
read -p "Supabase Project URL: " url
read -p "Supabase anon/public key: " key

if [ ! -z "$url" ] && [ ! -z "$key" ]; then
    file="flick-ios/Flick app IOS/Flick app IOS/Services/SupabaseService.swift"
    if [ -f "$file" ]; then
        # Backup original
        cp "$file" "$file.backup"
        # Update credentials
        sed -i '' "s|private let supabaseURL = \".*\"|private let supabaseURL = \"$url\"|" "$file"
        sed -i '' "s|private let supabaseKey = \".*\"|private let supabaseKey = \"$key\"|" "$file"
        echo "✅ Credentials updated!"
        echo "📁 Backup saved to: $file.backup"
    fi
fi
