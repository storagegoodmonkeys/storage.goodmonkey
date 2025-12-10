//
//  HomeView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI
import Foundation

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var mockData = MockData.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Subtle gradient background
                LinearGradient(
                    colors: [Color.white, Color(red: 0.98, green: 0.98, blue: 1.0)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header with Logo and QR Scan (prominent)
                        HStack {
                            // App Title/Logo
                            VStack(alignment: .leading, spacing: 2) {
                                Text("CLIPPER")
                                    .font(.system(size: 24, weight: .black))
                                    .foregroundColor(AppTheme.primary)
                                + Text(" VAULT")
                                    .font(.system(size: 24, weight: .black))
                                    .foregroundColor(AppTheme.textPrimary)
                            }
                            
                            Spacer()
                            
                            // QR Scan Button - Prominent (Client Request)
                            NavigationLink(destination: ScanView()) {
                                HStack(spacing: 6) {
                                    Image(systemName: "qrcode.viewfinder")
                                        .font(.system(size: 18, weight: .semibold))
                                    Text("Scan")
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(AppTheme.primary)
                                .cornerRadius(25)
                                .shadow(color: AppTheme.primary.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                        }
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        .padding(.top, AppTheme.Spacing.md)
                        .padding(.bottom, AppTheme.Spacing.lg)
                        
                        // Welcome Banner
                        WelcomeBanner()
                            .padding(.horizontal, AppTheme.Spacing.lg)
                            .padding(.bottom, AppTheme.Spacing.xl)
                        
                        // Quick Actions
                        QuickActionsRow()
                            .padding(.horizontal, AppTheme.Spacing.lg)
                            .padding(.bottom, AppTheme.Spacing.xl)
                        
                        // Your Lighters Section
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                            HStack {
                                Text("Your Lighters")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Spacer()
                                
                                NavigationLink(destination: CollectionView()) {
                                    Text("See All")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(AppTheme.primary)
                                }
                            }
                            .padding(.horizontal, AppTheme.Spacing.lg)
                            
                            if mockData.lighters.isEmpty {
                                EmptyLightersCard()
                                    .padding(.horizontal, AppTheme.Spacing.lg)
                            } else {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: AppTheme.Spacing.md) {
                                        ForEach(Array(mockData.lighters.prefix(5).enumerated()), id: \.element.id) { index, lighter in
                                            NavigationLink(destination: CollectionView()) {
                                                LighterHorizontalCard(
                                                    lighter: lighter,
                                                    index: index
                                                )
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                    .padding(.horizontal, AppTheme.Spacing.lg)
                                }
                            }
                        }
                        .padding(.bottom, AppTheme.Spacing.xl)
                        
                        // Campaigns & Giveaways
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                            HStack {
                                Text("🎁 Campaigns & Giveaways")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Spacer()
                            }
                            .padding(.horizontal, AppTheme.Spacing.lg)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: AppTheme.Spacing.md) {
                                    CampaignCardClipper(
                                        title: "LIMITED EDITION DROP",
                                        subtitle: "Exclusive designs only for members",
                                        date: "20/12/2024",
                                        gradient: [Color(red: 1.0, green: 0.4, blue: 0.2), Color(red: 1.0, green: 0.6, blue: 0.3)],
                                        lighterIndex: 0
                                    )
                                    CampaignCardClipper(
                                        title: "WIN RARE CLIPPER SET",
                                        subtitle: "Enter the raffle now",
                                        date: "15/01/2025",
                                        gradient: [Color(red: 0.4, green: 0.3, blue: 0.9), Color(red: 0.6, green: 0.4, blue: 1.0)],
                                        lighterIndex: 1
                                    )
                                }
                                .padding(.horizontal, AppTheme.Spacing.lg)
                            }
                        }
                        .padding(.bottom, AppTheme.Spacing.xl)
                        
                        // Top Collectors
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                            HStack {
                                Text("🏆 Top Collectors")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Spacer()
                                
                                NavigationLink(destination: LeaderboardView()) {
                                    Text("View All")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(AppTheme.primary)
                                }
                            }
                            .padding(.horizontal, AppTheme.Spacing.lg)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: AppTheme.Spacing.md) {
                                    ForEach(1..<6) { rank in
                                        TopCollectionCard(rank: rank)
                                    }
                                }
                                .padding(.horizontal, AppTheme.Spacing.lg)
                            }
                        }
                        .padding(.bottom, 100) // Extra space for tab bar
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Welcome Banner
struct WelcomeBanner: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 1.0, green: 0.45, blue: 0.2),
                            Color(red: 1.0, green: 0.6, blue: 0.35)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: Color(red: 1.0, green: 0.45, blue: 0.2).opacity(0.3), radius: 15, x: 0, y: 8)
            
            // Content
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome back! 👋")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                    
                    Text(appState.currentUser?.username ?? "Collector")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 12))
                        Text("\(MockData.shared.lighters.count) Lighters")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundColor(.white.opacity(0.9))
                }
                
                Spacer()
                
                // Decorative lighter icon
                Image(systemName: "flame.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white.opacity(0.3))
            }
            .padding(AppTheme.Spacing.lg)
        }
        .frame(height: 140)
    }
}

// MARK: - Quick Actions
struct QuickActionsRow: View {
    var body: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            NavigationLink(destination: ScanView()) {
                QuickActionButton(
                    icon: "qrcode.viewfinder",
                    title: "Add Lighter",
                    color: AppTheme.primary
                )
            }
            
            NavigationLink(destination: LostFoundView()) {
                QuickActionButton(
                    icon: "magnifyingglass",
                    title: "Lost & Found",
                    color: Color.blue
                )
            }
            
            NavigationLink(destination: MessagesListView()) {
                QuickActionButton(
                    icon: "bubble.left.and.bubble.right.fill",
                    title: "Messages",
                    color: Color.purple
                )
            }
        }
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.12))
                    .frame(width: 56, height: 56)
                
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(color)
            }
            
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Empty Lighters
struct EmptyLightersCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.backgroundSecondary)
                .frame(height: 160)
            
            VStack(spacing: 12) {
                Image(systemName: "flame")
                    .font(.system(size: 40))
                    .foregroundColor(AppTheme.textTertiary)
                
                Text("No lighters yet")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppTheme.textSecondary)
                
                Text("Scan a QR code to add your first lighter!")
                    .font(.system(size: 13))
                    .foregroundColor(AppTheme.textTertiary)
            }
        }
    }
}

// MARK: - Lighter Card
struct LighterHorizontalCard: View {
    let lighter: Lighter
    let index: Int
    
    var body: some View {
        VStack(spacing: AppTheme.Spacing.xs) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .frame(width: 120, height: 160)
                    .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                
                LighterImageView(lighter: lighter, index: index)
                    .frame(width: 120, height: 160)
            }
            
            Text(lighter.brand ?? "Clipper")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(1)
                .frame(width: 120)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Campaign Card
struct CampaignCardClipper: View {
    let title: String
    let subtitle: String
    let date: String
    let gradient: [Color]
    let lighterIndex: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: gradient,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: gradient[0].opacity(0.4), radius: 12, x: 0, y: 6)
            
            HStack(spacing: AppTheme.Spacing.md) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.85))
                    
                    Spacer()
                    
                    Text(date)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Lighter silhouette
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 70, height: 100)
                        .rotationEffect(.degrees(10))
                    
                    Image(systemName: "flame.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            .padding(AppTheme.Spacing.lg)
        }
        .frame(width: 280, height: 150)
    }
}

// MARK: - Top Collection Card
struct TopCollectionCard: View {
    let rank: Int
    
    private var rankColor: Color {
        switch rank {
        case 1: return Color(red: 1.0, green: 0.84, blue: 0.0) // Gold
        case 2: return Color(red: 0.75, green: 0.75, blue: 0.75) // Silver
        case 3: return Color(red: 0.8, green: 0.5, blue: 0.2) // Bronze
        default: return AppTheme.textSecondary
        }
    }
    
    var body: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.95, green: 0.95, blue: 0.97),
                                Color(red: 0.9, green: 0.9, blue: 0.92)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 70, height: 70)
                
                Image(systemName: "person.fill")
                    .font(.system(size: 28))
                    .foregroundColor(AppTheme.textTertiary)
                
                // Rank badge
                Text("\(rank)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 24, height: 24)
                    .background(rankColor)
                    .clipShape(Circle())
                    .offset(x: 25, y: -25)
            }
            
            VStack(spacing: 2) {
                Text("@collector\(rank)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text("\(150 - rank * 10) lighters")
                    .font(.system(size: 11))
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
        .frame(width: 100)
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
