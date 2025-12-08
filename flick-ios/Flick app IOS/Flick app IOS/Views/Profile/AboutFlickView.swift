//
//  AboutFlickView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct AboutFlickView: View {
    @Environment(\.dismiss) var dismiss
    
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
                        
                        Text("About Flick")
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
                    
                    VStack(spacing: AppTheme.Spacing.xl) {
                        // App Icon
                        Image("Flick_Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .cornerRadius(AppTheme.Radius.lg)
                        
                        VStack(spacing: AppTheme.Spacing.sm) {
                            Text("Flick")
                                .font(AppTheme.Typography.title1)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Text("Version 1.0.0")
                                .font(AppTheme.Typography.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                            Text("About")
                                .font(AppTheme.Typography.title3)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Text("Flick is the world's first lighter tracking app. Never lose your lighter again. Track, trade, and collect unique lighters with our global community.")
                                .font(AppTheme.Typography.body)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        .padding(.horizontal, AppTheme.Spacing.lg)
                    }
                    .padding(.top, AppTheme.Spacing.xl)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        AboutFlickView()
    }
}

