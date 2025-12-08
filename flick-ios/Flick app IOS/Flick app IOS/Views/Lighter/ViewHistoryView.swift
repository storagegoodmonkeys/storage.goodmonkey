//
//  ViewHistoryView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI
import Foundation

struct ViewHistoryView: View {
    @Environment(\.dismiss) var dismiss
    let lighter: Lighter
    
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
                        
                        Text("Ownership History")
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
                    
                    // History Timeline
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                        Text("QR Code: \(lighter.qrCode)")
                            .font(AppTheme.Typography.title3)
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(.horizontal, AppTheme.Spacing.lg)
                        
                        // Timeline
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                            HistoryTimelineItem(
                                date: lighter.registeredAt,
                                title: "Registered",
                                description: "Registered by you",
                                isFirst: true
                            )
                            
                            // Placeholder for future history items
                            Text("No additional history")
                                .font(AppTheme.Typography.caption1)
                                .foregroundColor(AppTheme.textSecondary)
                                .padding(.leading, AppTheme.Spacing.xl)
                                .padding(.top, AppTheme.Spacing.sm)
                        }
                        .padding(.horizontal, AppTheme.Spacing.lg)
                    }
                    .padding(.top, AppTheme.Spacing.lg)
                    
                    Spacer()
                        .frame(height: AppTheme.Spacing.xl)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct HistoryTimelineItem: View {
    let date: Date
    let title: String
    let description: String
    let isFirst: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: AppTheme.Spacing.md) {
            // Timeline indicator
            VStack(spacing: 0) {
                Circle()
                    .fill(AppTheme.primary)
                    .frame(width: 12, height: 12)
                
                if !isFirst {
                    Rectangle()
                        .fill(AppTheme.border)
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                } else {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 2, height: 40)
                }
            }
            .frame(width: 20)
            
            // Content
            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                Text(title)
                    .font(AppTheme.Typography.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(description)
                    .font(AppTheme.Typography.caption1)
                    .foregroundColor(AppTheme.textSecondary)
                
                Text(date.formatted(date: .abbreviated, time: .omitted))
                    .font(AppTheme.Typography.caption2)
                    .foregroundColor(AppTheme.textTertiary)
            }
            
            Spacer()
        }
        .padding(.vertical, AppTheme.Spacing.xs)
    }
}

#Preview {
    NavigationStack {
        ViewHistoryView(lighter: MockData.shared.lighters[0])
    }
}

