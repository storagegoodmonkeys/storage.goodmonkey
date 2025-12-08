//
//  LeaderboardView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct LeaderboardView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: AppTheme.Spacing.md) {
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
                        
                        Text("Leaderboard")
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
                    
                    // Leaderboard List
                    VStack(spacing: AppTheme.Spacing.sm) {
                        ForEach(1..<11) { rank in
                            HStack(spacing: AppTheme.Spacing.md) {
                                Text("#\(rank)")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(AppTheme.textSecondary)
                                    .frame(width: 40)
                                
                                Circle()
                                    .fill(AppTheme.backgroundTertiary)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .foregroundColor(AppTheme.textSecondary)
                                    )
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("User \(rank)")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(AppTheme.textPrimary)
                                    
                                    Text("\(1000 - rank * 50) points")
                                        .font(.system(size: 13))
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                                
                                Spacer()
                            }
                            .padding(AppTheme.Spacing.md)
                            .background(Color.white)
                            .cornerRadius(AppTheme.Radius.md)
                            .shadow(color: AppTheme.shadowColorLight, radius: 2, x: 0, y: 1)
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
        LeaderboardView()
    }
}

