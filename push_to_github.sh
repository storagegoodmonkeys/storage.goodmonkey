#!/bin/bash

# Push to GitHub using Personal Access Token
# Run this script: ./push_to_github.sh

GITHUB_TOKEN="YOUR_GITHUB_TOKEN_HERE"
REPO_URL="https://github.com/storagegoodmonkeys/storage.goodmonkey.git"

echo "🚀 Pushing to GitHub..."
echo ""

# Set remote URL with token
git remote set-url origin "https://${GITHUB_TOKEN}@github.com/storagegoodmonkeys/storage.goodmonkey.git"

# Push
echo "Pushing commits..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Successfully pushed to GitHub!"
    echo "Repository: $REPO_URL"
    
    # Reset remote URL to clean version (without token)
    git remote set-url origin "https://github.com/storagegoodmonkeys/storage.goodmonkey.git"
    echo "✅ Remote URL cleaned"
else
    echo ""
    echo "❌ Push failed. Please check:"
    echo "1. Token permissions (needs 'repo' scope)"
    echo "2. Repository access"
    echo "3. Try manually: git push -u origin main"
fi

