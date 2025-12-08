//
//  NewMessageView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 08/12/2025.
//

import SwiftUI

struct NewMessageView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var users: [User] = []
    @State private var isLoading = true
    
    let onSelectUser: (User) -> Void
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return users
        }
        return users.filter { $0.username.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(AppTheme.textSecondary)
                        
                        Spacer()
                        
                        Text("New Message")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        // Invisible spacer for balance
                        Text("Cancel").opacity(0)
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    
                    Divider()
                    
                    // Search
                    HStack {
                        Text("To:")
                            .font(.system(size: 16))
                            .foregroundColor(AppTheme.textSecondary)
                        
                        TextField("Search users...", text: $searchText)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    
                    Divider()
                    
                    // Users list
                    if isLoading {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(filteredUsers) { user in
                                    Button(action: {
                                        HapticManager.shared.impact(.light)
                                        onSelectUser(user)
                                        dismiss()
                                    }) {
                                        HStack(spacing: AppTheme.Spacing.md) {
                                            // Avatar
                                            ZStack {
                                                Circle()
                                                    .fill(AppTheme.backgroundTertiary)
                                                    .frame(width: 50, height: 50)
                                                
                                                Text(user.username.prefix(1).uppercased())
                                                    .font(.system(size: 20, weight: .semibold))
                                                    .foregroundColor(AppTheme.primary)
                                            }
                                            
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(user.username)
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundColor(AppTheme.textPrimary)
                                                
                                                Text(user.level.rawValue + " • \(user.points) points")
                                                    .font(.system(size: 13))
                                                    .foregroundColor(AppTheme.textSecondary)
                                            }
                                            
                                            Spacer()
                                        }
                                        .padding(.horizontal, AppTheme.Spacing.lg)
                                        .padding(.vertical, AppTheme.Spacing.md)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    Divider()
                                        .padding(.leading, 76)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                loadUsers()
            }
        }
    }
    
    private func loadUsers() {
        isLoading = true
        // Load sample users for testing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            users = [
                User(id: "user-2", email: "alice@test.com", username: "AliceCollector", avatarUrl: nil, bio: "Lighter enthusiast", location: "NYC", points: 250, level: .silver, createdAt: Date()),
                User(id: "user-3", email: "bob@test.com", username: "BobTrader", avatarUrl: nil, bio: "Trading rare lighters", location: "LA", points: 180, level: .bronze, createdAt: Date()),
                User(id: "user-4", email: "carol@test.com", username: "CarolVintage", avatarUrl: nil, bio: "Vintage lighter collector", location: "Chicago", points: 320, level: .gold, createdAt: Date()),
                User(id: "user-5", email: "dan@test.com", username: "DanFlame", avatarUrl: nil, bio: "Fire lover", location: "Miami", points: 150, level: .bronze, createdAt: Date()),
                User(id: "user-6", email: "eve@test.com", username: "EveRare", avatarUrl: nil, bio: "Rare finds only", location: "Boston", points: 420, level: .platinum, createdAt: Date())
            ]
            isLoading = false
        }
    }
}

#Preview {
    NewMessageView { user in
        print("Selected: \(user.username)")
    }
}
