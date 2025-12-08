//
//  MarketplaceView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI
import Foundation

struct MarketplaceView: View {
    let mockData = MockData.shared
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Marketplace")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(AppTheme.textPrimary)
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    
                    Divider()
                        .background(AppTheme.border)
                    
                    // Content
                    if mockData.marketplaceLighters.isEmpty {
                        Spacer()
                        Text("No lighters available")
                            .font(AppTheme.Typography.title3)
                            .foregroundColor(AppTheme.textSecondary)
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: AppTheme.Spacing.md) {
                                ForEach(Array(mockData.marketplaceLighters.enumerated()), id: \.element.id) { index, lighter in
                                    NavigationLink(destination: LighterDetailView(lighter: lighter)) {
                                        MarketplaceCard(
                                            lighter: lighter,
                                            index: index + mockData.lighters.count
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, AppTheme.Spacing.lg)
                            .padding(.vertical, AppTheme.Spacing.md)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct MarketplaceCard: View {
    let lighter: Lighter
    let index: Int
    
    var body: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            // ONE Lighter Image - designed programmatically
            ZStack {
                RoundedRectangle(cornerRadius: AppTheme.Radius.sm)
                    .fill(Color.white)
                    .frame(width: 80, height: 80)
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                
                LighterImageView(lighter: lighter, index: index)
                    .frame(width: 80, height: 80)
                    .scaleEffect(0.5)
            }
            
            // Details
            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                Text(lighter.brand ?? "Unknown")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(lighter.qrCode)
                    .font(.system(size: 13))
                    .foregroundColor(AppTheme.textSecondary)
                
                HStack(spacing: AppTheme.Spacing.xs) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.textSecondary)
                    Text("user\(Int.random(in: 2...5))")
                        .font(.system(size: 13))
                        .foregroundColor(AppTheme.textSecondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(AppTheme.textTertiary)
        }
        .padding(AppTheme.Spacing.md)
        .background(Color.white)
        .cornerRadius(AppTheme.Radius.md)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    MarketplaceView()
}
