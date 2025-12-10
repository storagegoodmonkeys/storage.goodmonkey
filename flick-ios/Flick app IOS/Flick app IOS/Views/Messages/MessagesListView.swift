//
//  MessagesListView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 08/12/2025.
//

import SwiftUI

struct MessagesListView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    var isTab: Bool = true  // Default to tab view
    @State private var searchText = ""
    @State private var conversations: [ConversationWithUser] = []
    @State private var isLoading = true
    @State private var showNewMessage = false
    
    var filteredConversations: [ConversationWithUser] {
        if searchText.isEmpty {
            return conversations
        }
        return conversations.filter { $0.otherUser.username.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    if !isTab {
                        Button(action: {
                            HapticManager.shared.impact(.light)
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(AppTheme.textPrimary)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Messages")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Spacer()
                    
                    Button(action: {
                        HapticManager.shared.impact(.light)
                        showNewMessage = true
                    }) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 18))
                            .foregroundColor(AppTheme.primary)
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.vertical, AppTheme.Spacing.md)
                
                Divider()
                    .background(AppTheme.border)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(AppTheme.textSecondary)
                    
                    TextField("Search conversations", text: $searchText)
                        .font(AppTheme.Typography.body)
                }
                .padding(AppTheme.Spacing.sm)
                .background(AppTheme.backgroundSecondary)
                .cornerRadius(AppTheme.Radius.sm)
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.vertical, AppTheme.Spacing.sm)
                
                if isLoading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: AppTheme.primary))
                    Spacer()
                } else if conversations.isEmpty {
                    Spacer()
                    VStack(spacing: AppTheme.Spacing.md) {
                        Image(systemName: "bubble.left.and.bubble.right")
                            .font(.system(size: 60))
                            .foregroundColor(AppTheme.textTertiary)
                        
                        Text("No Messages Yet")
                            .font(AppTheme.Typography.headline)
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Text("Start a conversation with other collectors")
                            .font(AppTheme.Typography.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            HapticManager.shared.impact(.medium)
                            showNewMessage = true
                        }) {
                            Text("Start Chat")
                                .font(AppTheme.Typography.headline)
                                .foregroundColor(.white)
                                .frame(width: 150, height: 44)
                                .background(AppTheme.primary)
                                .cornerRadius(AppTheme.Radius.button)
                        }
                        .padding(.top, AppTheme.Spacing.sm)
                    }
                    .padding()
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(filteredConversations) { convo in
                                NavigationLink(destination: ChatView(conversation: convo.conversation, otherUser: convo.otherUser)) {
                                    ConversationRow(conversation: convo)
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
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showNewMessage) {
            NewMessageView { user in
                // Start conversation with selected user
                startConversation(with: user)
            }
        }
        .onAppear {
            loadConversations()
        }
    }
    
    private func loadConversations() {
        isLoading = true
        // For testing, create some sample conversations
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let sampleUsers = [
                User(id: "user-2", email: "alice@test.com", username: "AliceCollector", avatarUrl: nil, bio: "Lighter enthusiast", location: "NYC", points: 250, level: .silver, createdAt: Date()),
                User(id: "user-3", email: "bob@test.com", username: "BobTrader", avatarUrl: nil, bio: "Trading rare lighters", location: "LA", points: 180, level: .bronze, createdAt: Date()),
                User(id: "user-4", email: "carol@test.com", username: "CarolVintage", avatarUrl: nil, bio: "Vintage lighter collector", location: "Chicago", points: 320, level: .gold, createdAt: Date())
            ]
            
            conversations = sampleUsers.enumerated().map { index, user in
                ConversationWithUser(
                    id: "conv-\(index)",
                    conversation: Conversation(
                        id: "conv-\(index)",
                        participant1Id: appState.currentUser?.id ?? "current",
                        participant2Id: user.id,
                        lastMessage: ["Hey! Nice collection!", "Interested in trading?", "Thanks for the lighter!"][index],
                        lastMessageAt: Date().addingTimeInterval(-Double(index * 3600)),
                        unreadCount: index == 0 ? 2 : 0,
                        createdAt: Date().addingTimeInterval(-Double(index * 86400))
                    ),
                    otherUser: user,
                    lastMessage: ["Hey! Nice collection!", "Interested in trading?", "Thanks for the lighter!"][index],
                    lastMessageAt: Date().addingTimeInterval(-Double(index * 3600)),
                    unreadCount: index == 0 ? 2 : 0
                )
            }
            isLoading = false
        }
    }
    
    private func startConversation(with user: User) {
        // Create new conversation
        let newConvo = ConversationWithUser(
            id: UUID().uuidString,
            conversation: Conversation(
                id: UUID().uuidString,
                participant1Id: appState.currentUser?.id ?? "current",
                participant2Id: user.id,
                lastMessage: nil,
                lastMessageAt: nil,
                unreadCount: 0,
                createdAt: Date()
            ),
            otherUser: user,
            lastMessage: nil,
            lastMessageAt: nil,
            unreadCount: 0
        )
        conversations.insert(newConvo, at: 0)
    }
}

// MARK: - Conversation Row
struct ConversationRow: View {
    let conversation: ConversationWithUser
    
    var body: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            // Avatar
            ZStack {
                Circle()
                    .fill(AppTheme.backgroundTertiary)
                    .frame(width: 56, height: 56)
                
                Text(conversation.otherUser.username.prefix(1).uppercased())
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(AppTheme.primary)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(conversation.otherUser.username)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Spacer()
                    
                    if let lastTime = conversation.lastMessageAt {
                        Text(timeAgo(from: lastTime))
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                }
                
                HStack {
                    Text(conversation.lastMessage ?? "Start a conversation")
                        .font(.system(size: 14))
                        .foregroundColor(conversation.unreadCount > 0 ? AppTheme.textPrimary : AppTheme.textSecondary)
                        .fontWeight(conversation.unreadCount > 0 ? .medium : .regular)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if conversation.unreadCount > 0 {
                        Text("\(conversation.unreadCount)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(AppTheme.primary)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
        .padding(.vertical, AppTheme.Spacing.md)
        .background(Color.white)
    }
    
    private func timeAgo(from date: Date) -> String {
        let seconds = Int(-date.timeIntervalSinceNow)
        if seconds < 60 { return "now" }
        if seconds < 3600 { return "\(seconds / 60)m" }
        if seconds < 86400 { return "\(seconds / 3600)h" }
        if seconds < 604800 { return "\(seconds / 86400)d" }
        return "\(seconds / 604800)w"
    }
}

#Preview {
    NavigationStack {
        MessagesListView()
            .environmentObject(AppState())
    }
}
