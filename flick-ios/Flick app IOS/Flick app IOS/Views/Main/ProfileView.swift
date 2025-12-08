//
//  ProfileView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var profileImage: UIImage? = nil
    
    var currentUser: User? {
        appState.currentUser ?? authManager.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: AppTheme.Spacing.lg) {
                        // Profile Header
                        VStack(spacing: AppTheme.Spacing.md) {
                            ZStack {
                                Circle()
                                    .fill(AppTheme.backgroundTertiary)
                                    .frame(width: 100, height: 100)
                                
                                Group {
                                    if let profileImage = profileImage {
                                        Image(uiImage: profileImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(Circle())
                                    } else if let avatarUrl = currentUser?.avatarUrl, !avatarUrl.isEmpty, avatarUrl.hasPrefix("data:image") {
                                        // Load base64 image
                                        if let image = loadBase64Image(from: avatarUrl) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(Circle())
                                        } else {
                                            Image(systemName: "person.fill")
                                                .font(.system(size: 48))
                                                .foregroundColor(AppTheme.textSecondary)
                                        }
                                    } else {
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 48))
                                            .foregroundColor(AppTheme.textSecondary)
                                    }
                                }
                            }
                            
                            Text(currentUser?.username ?? "User")
                                .font(AppTheme.Typography.title2)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Text((currentUser?.level.rawValue ?? "Bronze") + " Level")
                                .font(AppTheme.Typography.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        .padding(.top, AppTheme.Spacing.md)
                        .onAppear {
                            loadProfileImage()
                        }
                        .onChange(of: currentUser?.avatarUrl) { _, _ in
                            loadProfileImage()
                        }
                        
                        // Stats
                        HStack(spacing: AppTheme.Spacing.sm) {
                            ModernStatCard(number: "\(currentUser?.points ?? 0)", label: "Points", icon: "star.fill")
                            ModernStatCard(number: "\(MockData.shared.lighters.count)", label: "Lighters", icon: "flame.fill")
                            ModernStatCard(number: "\(MockData.shared.achievements.count)", label: "Achievements", icon: "trophy.fill")
                        }
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        
                        // Menu Sections
                        MenuSection(title: "Profile") {
                            NavigationLink(destination: EditProfileView()) {
                                MenuItemView(icon: "person.fill", title: "Edit Profile")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.impact(.light)
                            })
                            NavigationLink(destination: AchievementsView()) {
                                MenuItemView(icon: "trophy.fill", title: "Achievements")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.impact(.light)
                            })
                            NavigationLink(destination: LeaderboardView()) {
                                MenuItemView(icon: "chart.bar.fill", title: "Leaderboard")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.impact(.light)
                            })
                        }
                        
                        MenuSection(title: "Settings") {
                            NavigationLink(destination: NotificationsSettingsView()) {
                                MenuItemView(icon: "bell.fill", title: "Notifications")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.impact(.light)
                            })
                            NavigationLink(destination: PrivacySettingsView()) {
                                MenuItemView(icon: "lock.fill", title: "Privacy Settings")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.impact(.light)
                            })
                            NavigationLink(destination: LocationSettingsView()) {
                                MenuItemView(icon: "location.fill", title: "Location Settings")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.impact(.light)
                            })
                        }
                        
                        MenuSection(title: "About") {
                            NavigationLink(destination: HelpSupportView()) {
                                MenuItemView(icon: "info.circle.fill", title: "Help & Support")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.impact(.light)
                            })
                            NavigationLink(destination: TermsPrivacyView()) {
                                MenuItemView(icon: "doc.text.fill", title: "Terms & Privacy")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.impact(.light)
                            })
                            NavigationLink(destination: AboutFlickView()) {
                                MenuItemView(icon: "info.circle.fill", title: "About Flick")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.impact(.light)
                            })
                        }
                        
                        // Logout
                        Button(action: {
                            HapticManager.shared.impact(.medium)
                            appState.signOut()
                        }) {
                            Text("Sign Out")
                                .font(AppTheme.Typography.headline)
                                .foregroundColor(AppTheme.error)
                                .frame(maxWidth: .infinity)
                                .frame(height: AppTheme.Button.height)
                                .background(AppTheme.error.opacity(0.1))
                                .cornerRadius(AppTheme.Radius.md)
                        }
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        .padding(.bottom, AppTheme.Spacing.xl)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private func loadProfileImage() {
        guard let avatarUrl = currentUser?.avatarUrl, !avatarUrl.isEmpty else { return }
        
        if avatarUrl.hasPrefix("data:image") {
            profileImage = loadBase64Image(from: avatarUrl)
        } else if let url = URL(string: avatarUrl) {
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let image = UIImage(data: data) {
                        await MainActor.run {
                            profileImage = image
                        }
                    }
                } catch {
                    print("Failed to load profile image: \(error)")
                }
            }
        }
    }
    
    private func loadBase64Image(from dataUrl: String) -> UIImage? {
        guard let base64Range = dataUrl.range(of: "base64,") else { return nil }
        let base64String = String(dataUrl[base64Range.upperBound...])
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: imageData)
    }
}

struct MenuSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text(title.uppercased())
                .font(AppTheme.Typography.caption1)
                .fontWeight(.semibold)
                .foregroundColor(AppTheme.textSecondary)
                .padding(.horizontal, AppTheme.Spacing.lg)
            
            VStack(spacing: AppTheme.Spacing.xs) {
                content
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
        }
    }
}

// MenuItem for use with NavigationLink (no button wrapper)
struct MenuItemView: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(AppTheme.textPrimary)
                .frame(width: 24)
            
            Text(title)
                .font(AppTheme.Typography.subheadline)
                .foregroundColor(AppTheme.textPrimary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .foregroundColor(AppTheme.textTertiary)
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.background)
        .cornerRadius(AppTheme.Radius.md)
        .shadow(color: AppTheme.shadowColorLight, radius: 2, x: 0, y: 1)
        .contentShape(Rectangle())
    }
}

// MenuItem for standalone buttons (with action)
struct MenuItem: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.light)
            action()
        }) {
            HStack(spacing: AppTheme.Spacing.md) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(AppTheme.textPrimary)
                    .frame(width: 24)
                
                Text(title)
                    .font(AppTheme.Typography.subheadline)
                    .foregroundColor(AppTheme.textPrimary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(AppTheme.textTertiary)
            }
            .padding(AppTheme.Spacing.md)
            .background(AppTheme.background)
            .cornerRadius(AppTheme.Radius.md)
            .shadow(color: AppTheme.shadowColorLight, radius: 2, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
}
