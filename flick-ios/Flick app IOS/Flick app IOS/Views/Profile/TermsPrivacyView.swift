//
//  TermsPrivacyView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct TermsPrivacyView: View {
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
                        
                        Text("Terms & Privacy")
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
                    
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                        Text("Terms of Service")
                            .font(AppTheme.Typography.title3)
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Text("By using Flick, you agree to our terms of service. Please read them carefully.")
                            .font(AppTheme.Typography.body)
                            .foregroundColor(AppTheme.textSecondary)
                        
                        Text("Privacy Policy")
                            .font(AppTheme.Typography.title3)
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(.top, AppTheme.Spacing.md)
                        
                        Text("We value your privacy. Your data is encrypted and stored securely. We never share your information with third parties.")
                            .font(AppTheme.Typography.body)
                            .foregroundColor(AppTheme.textSecondary)
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
        TermsPrivacyView()
    }
}

