//
//  ChatView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 08/12/2025.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    let conversation: Conversation
    let otherUser: User
    
    @State private var messageText = ""
    @State private var messages: [Message] = []
    @State private var isLoading = true
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack(spacing: AppTheme.Spacing.md) {
                    Button(action: {
                        HapticManager.shared.impact(.light)
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                    }
                    
                    // User avatar
                    ZStack {
                        Circle()
                            .fill(AppTheme.backgroundTertiary)
                            .frame(width: 36, height: 36)
                        
                        Text(otherUser.username.prefix(1).uppercased())
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(AppTheme.primary)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(otherUser.username)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Text(otherUser.level.rawValue + " Collector")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: UserProfileView(user: otherUser)) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 20))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.vertical, AppTheme.Spacing.md)
                .background(Color.white)
                .shadow(color: AppTheme.shadowColorLight, radius: 2, y: 1)
                
                // Messages
                if isLoading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: AppTheme.primary))
                    Spacer()
                } else {
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: AppTheme.Spacing.sm) {
                                ForEach(messages) { message in
                                    MessageBubble(
                                        message: message,
                                        isCurrentUser: message.senderId == (appState.currentUser?.id ?? "current")
                                    )
                                    .id(message.id)
                                }
                            }
                            .padding(.horizontal, AppTheme.Spacing.lg)
                            .padding(.vertical, AppTheme.Spacing.md)
                        }
                        .onChange(of: messages.count) { _, _ in
                            if let lastMessage = messages.last {
                                withAnimation {
                                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                
                // Input bar
                HStack(spacing: AppTheme.Spacing.sm) {
                    // Text field
                    HStack {
                        TextField("Message...", text: $messageText)
                            .font(AppTheme.Typography.body)
                            .focused($isInputFocused)
                        
                        if !messageText.isEmpty {
                            Button(action: {
                                messageText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(AppTheme.textTertiary)
                            }
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.md)
                    .padding(.vertical, AppTheme.Spacing.sm)
                    .background(AppTheme.backgroundSecondary)
                    .cornerRadius(20)
                    
                    // Send button
                    Button(action: {
                        sendMessage()
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 18))
                            .foregroundColor(messageText.isEmpty ? AppTheme.textTertiary : AppTheme.primary)
                            .frame(width: 40, height: 40)
                            .background(messageText.isEmpty ? AppTheme.backgroundSecondary : AppTheme.primary.opacity(0.1))
                            .clipShape(Circle())
                    }
                    .disabled(messageText.isEmpty)
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.vertical, AppTheme.Spacing.sm)
                .background(Color.white)
                .shadow(color: AppTheme.shadowColorLight, radius: 2, y: -1)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            loadMessages()
        }
        .onTapGesture {
            isInputFocused = false
        }
    }
    
    private func loadMessages() {
        isLoading = true
        // Load sample messages for testing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let currentUserId = appState.currentUser?.id ?? "current"
            messages = [
                Message(id: "msg-1", conversationId: conversation.id, senderId: otherUser.id, content: "Hey! I saw your lighter collection", isRead: true, createdAt: Date().addingTimeInterval(-3600)),
                Message(id: "msg-2", conversationId: conversation.id, senderId: currentUserId, content: "Thanks! I've been collecting for a while", isRead: true, createdAt: Date().addingTimeInterval(-3500)),
                Message(id: "msg-3", conversationId: conversation.id, senderId: otherUser.id, content: "That vintage Clipper looks amazing! Would you be interested in a trade?", isRead: true, createdAt: Date().addingTimeInterval(-3400)),
                Message(id: "msg-4", conversationId: conversation.id, senderId: currentUserId, content: "Which one are you interested in?", isRead: true, createdAt: Date().addingTimeInterval(-3300)),
                Message(id: "msg-5", conversationId: conversation.id, senderId: otherUser.id, content: "The Ocean design one! I have some rare pieces I could offer", isRead: true, createdAt: Date().addingTimeInterval(-3200))
            ]
            isLoading = false
        }
    }
    
    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        HapticManager.shared.impact(.light)
        
        let newMessage = Message(
            id: UUID().uuidString,
            conversationId: conversation.id,
            senderId: appState.currentUser?.id ?? "current",
            content: messageText,
            isRead: false,
            createdAt: Date()
        )
        
        messages.append(newMessage)
        messageText = ""
        
        // Simulate reply after a moment
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let replies = [
                "That sounds great!",
                "Let me check my collection",
                "I'll send you some photos",
                "Perfect, thanks!",
                "Looking forward to it!"
            ]
            let reply = Message(
                id: UUID().uuidString,
                conversationId: conversation.id,
                senderId: otherUser.id,
                content: replies.randomElement() ?? "Thanks!",
                isRead: false,
                createdAt: Date()
            )
            messages.append(reply)
        }
    }
}

// MARK: - Message Bubble
struct MessageBubble: View {
    let message: Message
    let isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isCurrentUser { Spacer(minLength: 60) }
            
            VStack(alignment: isCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .font(.system(size: 15))
                    .foregroundColor(isCurrentUser ? .white : AppTheme.textPrimary)
                    .padding(.horizontal, AppTheme.Spacing.md)
                    .padding(.vertical, AppTheme.Spacing.sm)
                    .background(isCurrentUser ? AppTheme.primary : AppTheme.backgroundSecondary)
                    .cornerRadius(18)
                
                Text(formatTime(message.createdAt))
                    .font(.system(size: 10))
                    .foregroundColor(AppTheme.textTertiary)
            }
            
            if !isCurrentUser { Spacer(minLength: 60) }
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// MARK: - User Profile View (placeholder)
struct UserProfileView: View {
    let user: User
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: AppTheme.Spacing.lg) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                    }
                    Spacer()
                    Text("Profile")
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                    Color.clear.frame(width: 24)
                }
                .padding()
                
                // Avatar
                ZStack {
                    Circle()
                        .fill(AppTheme.backgroundTertiary)
                        .frame(width: 100, height: 100)
                    
                    Text(user.username.prefix(1).uppercased())
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundColor(AppTheme.primary)
                }
                
                Text(user.username)
                    .font(.system(size: 24, weight: .bold))
                
                Text(user.level.rawValue + " Collector")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.textSecondary)
                
                Text("\(user.points) points")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppTheme.primary)
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        ChatView(
            conversation: Conversation(id: "1", participant1Id: "current", participant2Id: "user-2", lastMessage: "Hey!", lastMessageAt: Date(), unreadCount: 0, createdAt: Date()),
            otherUser: User(id: "user-2", email: "test@test.com", username: "TestUser", avatarUrl: nil, bio: "Collector", location: "NYC", points: 100, level: .silver, createdAt: Date())
        )
        .environmentObject(AppState())
    }
}
