//
//  PrivacySettingsView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct PrivacySettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var profilePublic = true
    @State private var showLocation = false
    @State private var allowTrades = true
    
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
                        
                        Text("Privacy Settings")
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
                        ToggleRow(title: "Public Profile", isOn: $profilePublic, icon: "person.fill")
                        ToggleRow(title: "Show Location", isOn: $showLocation, icon: "location.fill")
                        ToggleRow(title: "Allow Trade Requests", isOn: $allowTrades, icon: "hand.raised.fill")
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
        PrivacySettingsView()
    }
}

