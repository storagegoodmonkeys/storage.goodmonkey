//
//  LighterDetailView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI
import Foundation

struct LighterDetailView: View {
    let lighter: Lighter
    @Environment(\.dismiss) var dismiss
    
    var lighterIndex: Int {
        MockData.shared.lighters.firstIndex(where: { $0.id == lighter.id }) ?? 0
    }
    
    var body: some View {
        ZStack {
            AppTheme.backgroundSecondary.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: AppTheme.Spacing.lg) {
                    // Header
                    HStack {
                        Button(action: { dismiss() }) {
                            HStack(spacing: AppTheme.Spacing.xs) {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .font(AppTheme.Typography.subheadline)
                            .foregroundColor(AppTheme.primary)
                        }
                        
                        Spacer()
                        
                        Text("Lighter Details")
                            .font(AppTheme.Typography.title3)
                            .foregroundColor(AppTheme.textPrimary)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Color.clear
                            .frame(width: 60)
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.top, AppTheme.Spacing.md)
                    
                    // Lighter Image - Large and prominent, ONE lighter design
                    ZStack {
                        RoundedRectangle(cornerRadius: AppTheme.Radius.lg)
                            .fill(Color.white)
                            .frame(height: 350)
                            .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 4)
                        
                        LighterImageView(lighter: lighter, index: lighterIndex)
                            .frame(height: 330)
                            .scaleEffect(1.5)
                            .padding(AppTheme.Spacing.md)
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    
                    // Info Card
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                        Text(lighter.brand ?? "Unknown Brand")
                            .font(AppTheme.Typography.title1)
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Text("QR Code: \(lighter.qrCode)")
                            .font(AppTheme.Typography.caption1)
                            .foregroundColor(AppTheme.textSecondary)
                        
                        Divider()
                            .background(AppTheme.border)
                        
                        DetailRow(label: "Status", value: lighter.status.displayName, valueColor: statusColor)
                        
                        if let color = lighter.color {
                            DetailRow(label: "Color", value: color, valueColor: AppTheme.textPrimary)
                        }
                        
                        DetailRow(
                            label: "Registered",
                            value: lighter.registeredAt.formatted(date: .abbreviated, time: .omitted),
                            valueColor: AppTheme.textPrimary
                        )
                    }
                    .padding(AppTheme.Spacing.lg)
                    .modernCard()
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    
                    // Actions
                    HStack(spacing: AppTheme.Spacing.sm) {
                        NavigationLink(destination: EditLighterView(lighter: lighter)) {
                            Text("Edit Details")
                                .font(AppTheme.Typography.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: AppTheme.Button.height)
                                .background(AppTheme.primary)
                                .cornerRadius(AppTheme.Radius.button)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            HapticManager.shared.impact(.medium)
                        })
                        
                        NavigationLink(destination: ViewHistoryView(lighter: lighter)) {
                            Text("View History")
                                .font(AppTheme.Typography.headline)
                                .foregroundColor(AppTheme.primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: AppTheme.Button.height)
                                .background(AppTheme.background)
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppTheme.Radius.button)
                                        .stroke(AppTheme.primary, lineWidth: 1.5)
                                )
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            HapticManager.shared.impact(.medium)
                        })
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    
                    // Ownership History
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                        Text("Ownership History")
                            .font(AppTheme.Typography.title3)
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(.horizontal, AppTheme.Spacing.lg)
                        
                        HistoryCard(date: lighter.registeredAt, text: "Registered by you")
                    }
                    .padding(.top, AppTheme.Spacing.sm)
                    
                    Spacer()
                        .frame(height: AppTheme.Spacing.xl)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    var statusColor: Color {
        switch lighter.status {
        case .owned: return AppTheme.success
        case .lost: return AppTheme.error
        case .trading: return AppTheme.warning
        case .found: return AppTheme.success
        }
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    let valueColor: Color
    
    var body: some View {
        HStack {
            Text(label + ":")
                .font(AppTheme.Typography.caption1)
                .foregroundColor(AppTheme.textSecondary)
            
            Spacer()
            
            Text(value)
                .font(AppTheme.Typography.caption1)
                .fontWeight(.semibold)
                .foregroundColor(valueColor)
        }
    }
}

struct HistoryCard: View {
    let date: Date
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: AppTheme.Spacing.sm) {
            Image(systemName: "circle.fill")
                .font(.system(size: 8))
                .foregroundColor(AppTheme.primary)
            
            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                Text(text)
                    .font(AppTheme.Typography.caption1)
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(date.formatted(date: .abbreviated, time: .omitted))
                    .font(AppTheme.Typography.caption2)
                    .foregroundColor(AppTheme.textSecondary)
            }
            
            Spacer()
        }
        .padding(AppTheme.Spacing.md)
        .modernCard()
        .padding(.horizontal, AppTheme.Spacing.lg)
    }
}

#Preview {
    NavigationStack {
        LighterDetailView(lighter: MockData.shared.lighters[0])
    }
}
