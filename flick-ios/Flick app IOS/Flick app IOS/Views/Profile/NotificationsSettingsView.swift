//
//  NotificationsSettingsView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct NotificationsSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var pushEnabled = true
    @State private var emailEnabled = true
    @State private var tradeEnabled = true
    @State private var foundEnabled = true
    
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
                        
                        Text("Notifications")
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
                    
                    // Settings
                    VStack(spacing: AppTheme.Spacing.md) {
                        ToggleRow(title: "Push Notifications", isOn: $pushEnabled, icon: "bell.fill")
                        ToggleRow(title: "Email Notifications", isOn: $emailEnabled, icon: "envelope.fill")
                        ToggleRow(title: "Trade Updates", isOn: $tradeEnabled, icon: "arrow.triangle.swap")
                        ToggleRow(title: "Found Lighters", isOn: $foundEnabled, icon: "magnifyingglass")
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.top, AppTheme.Spacing.lg)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct ToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    let icon: String
    
    var body: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(AppTheme.primary)
                .frame(width: 24)
            
            Text(title)
                .font(AppTheme.Typography.subheadline)
                .foregroundColor(AppTheme.textPrimary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .onChange(of: isOn) { _, _ in
                    HapticManager.shared.selection()
                }
        }
        .padding(AppTheme.Spacing.md)
        .background(Color.white)
        .cornerRadius(AppTheme.Radius.md)
        .shadow(color: AppTheme.shadowColorLight, radius: 2, x: 0, y: 1)
    }
}

#Preview {
    NavigationStack {
        NotificationsSettingsView()
    }
}

