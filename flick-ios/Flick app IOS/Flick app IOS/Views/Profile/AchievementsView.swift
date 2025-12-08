//
//  AchievementsView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct AchievementsView: View {
    @Environment(\.dismiss) var dismiss
    let mockData = MockData.shared
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: AppTheme.Spacing.lg) {
                    // Header
                    HStack {
                        Button(action: {
                            HapticManager.shared.impact(.light)
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18))
                                .foregroundColor(AppTheme.textPrimary)
                        }
                        
                        Spacer()
                        
                        Text("Achievements")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        Color.clear
                            .frame(width: 30)
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    
                    Divider()
                        .background(AppTheme.border)
                    
                    // Achievements Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: AppTheme.Spacing.md),
                        GridItem(.flexible(), spacing: AppTheme.Spacing.md),
                        GridItem(.flexible(), spacing: AppTheme.Spacing.md)
                    ], spacing: AppTheme.Spacing.lg) {
                        ForEach(mockData.achievements) { achievement in
                            VStack(spacing: AppTheme.Spacing.sm) {
                                ZStack {
                                    Circle()
                                        .fill(AppTheme.primary.opacity(0.1))
                                        .frame(width: 80, height: 80)
                                    
                                    Image(systemName: achievement.icon)
                                        .font(.system(size: 36))
                                        .foregroundColor(AppTheme.primary)
                                }
                                
                                Text(achievement.title)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.top, AppTheme.Spacing.lg)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        AchievementsView()
    }
}

