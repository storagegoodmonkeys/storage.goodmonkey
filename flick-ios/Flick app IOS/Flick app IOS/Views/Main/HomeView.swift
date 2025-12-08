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
                Color.white.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Header with Title and Icons (including Messages like Instagram)
                        HStack {
                            Text("CLIPPER VAULT")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Spacer()
                            
                            HStack(spacing: AppTheme.Spacing.md) {
                                // Messages icon (like Instagram DM)
                                NavigationLink(destination: MessagesListView()) {
                                    ZStack(alignment: .topTrailing) {
                                        Image(systemName: "paperplane")
                                            .font(.system(size: 20))
                                            .foregroundColor(AppTheme.textPrimary)
                                        
                                        // Unread indicator dot
                                        Circle()
                                            .fill(AppTheme.primary)
                                            .frame(width: 8, height: 8)
                                            .offset(x: 2, y: -2)
                                    }
                                }
                                
                                NavigationLink(destination: ScanView()) {
                                    Image(systemName: "qrcode.viewfinder")
                                        .font(.system(size: 20))
                                        .foregroundColor(AppTheme.textPrimary)
                                }
                                
                                NavigationLink(destination: ProfileView()) {
                                    Image(systemName: "person.circle")
                                        .font(.system(size: 24))
                                        .foregroundColor(AppTheme.textPrimary)
                                }
                            }
                        }
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        .padding(.vertical, AppTheme.Spacing.md)
                        
                        Divider()
                            .background(AppTheme.border)
                        
                        // Latest Lighters Section - ONE lighter per card
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                            Text("Latest Lighters")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(AppTheme.textPrimary)
                                .padding(.horizontal, AppTheme.Spacing.lg)
                                .padding(.top, AppTheme.Spacing.lg)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: AppTheme.Spacing.md) {
                                    // Show first 5 lighters - each with ONE unique design
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
                        .padding(.bottom, AppTheme.Spacing.xl)
                        
                        // Latest Campaigns/Giveaways Section
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                            Text("Latest Campaigns/Giveaways")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(AppTheme.textPrimary)
                                .padding(.horizontal, AppTheme.Spacing.lg)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: AppTheme.Spacing.md) {
                                    CampaignCardClipper(
                                        title: "LIMITED EDITION DROP",
                                        date: "20/12/2024",
                                        gradient: [Color(red: 0.2, green: 0.3, blue: 0.5), Color(red: 0.1, green: 0.2, blue: 0.4)],
                                        lighterIndex: 0
                                    )
                                    CampaignCardClipper(
                                        title: "WIN A RARE CLIPPER SET",
                                        date: "15/04/2024",
                                        gradient: [Color(red: 0.5, green: 0.2, blue: 0.6), Color(red: 0.4, green: 0.1, blue: 0.5)],
                                        lighterIndex: 1
                                    )
                                }
                                .padding(.horizontal, AppTheme.Spacing.lg)
                            }
                        }
                        .padding(.bottom, AppTheme.Spacing.xl)
                        
                        // Top 100 Collections Section
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                            Text("Top 100 Collections")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(AppTheme.textPrimary)
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
                        .padding(.bottom, AppTheme.Spacing.xl)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct LighterHorizontalCard: View {
    let lighter: Lighter
    let index: Int
    
    var body: some View {
        VStack(spacing: AppTheme.Spacing.xs) {
            ZStack {
                RoundedRectangle(cornerRadius: AppTheme.Radius.md)
                    .fill(Color.white)
                    .frame(width: 120, height: 160)
                    .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                
                // ONE Lighter - Designed programmatically
                LighterImageView(lighter: lighter, index: index)
                    .frame(width: 120, height: 160)
            }
            
            // Lighter Name - below the image
            Text(lighter.brand ?? "Unknown")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(1)
                .frame(width: 120)
                .multilineTextAlignment(.center)
        }
    }
}

struct CampaignCardClipper: View {
    let title: String
    let date: String
    let gradient: [Color]
    let lighterIndex: Int
    
    var body: some View {
        ZStack {
            // Background with gradient
            ZStack {
                LinearGradient(
                    colors: gradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Abstract wave pattern overlay
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.1),
                                Color.clear
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .frame(width: 280, height: 160)
            .cornerRadius(16)
            
            // Content
            HStack(spacing: AppTheme.Spacing.md) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                    // Title stacked vertically
                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(title.components(separatedBy: " "), id: \.self) { word in
                            Text(word)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Text(date)
                        .font(.system(size: 11))
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.top, 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Lighter - ONE lighter design, Tilted
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.2))
                        .frame(width: 80, height: 120)
                        .rotationEffect(.degrees(-15))
                    
                    LighterImageView(
                        lighter: MockData.shared.lighters[min(lighterIndex, MockData.shared.lighters.count - 1)],
                        index: lighterIndex
                    )
                    .frame(width: 70, height: 110)
                    .rotationEffect(.degrees(15))
                }
            }
            .padding(AppTheme.Spacing.md)
        }
        .frame(width: 280, height: 160)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

struct TopCollectionCard: View {
    let rank: Int
    
    var body: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            // Profile Picture
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.85, green: 0.85, blue: 0.9),
                                Color(red: 0.9, green: 0.9, blue: 0.95)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 70, height: 70)
                
                Image(systemName: "person.fill")
                    .font(.system(size: 32))
                    .foregroundColor(AppTheme.textSecondary)
            }
            
            // Username and Name
            VStack(spacing: 2) {
                Text("Clipper")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text("Usemlaime")
                    .font(.system(size: 11))
                    .foregroundColor(AppTheme.textSecondary)
            }
            
            // Rank
            Text("#\(rank)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(AppTheme.textPrimary)
        }
        .frame(width: 100)
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
