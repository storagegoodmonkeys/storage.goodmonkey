//
//  HelpSupportView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct HelpSupportView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showFAQ = false
    @State private var showContact = false
    @State private var showReportBug = false
    @State private var showFeatureRequest = false
    
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
                        
                        Text("Help & Support")
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
                    
                    VStack(spacing: AppTheme.Spacing.md) {
                        SupportRow(title: "FAQ", icon: "questionmark.circle.fill") {
                            HapticManager.shared.impact(.medium)
                            showFAQ = true
                        }
                        SupportRow(title: "Contact Us", icon: "envelope.fill") {
                            HapticManager.shared.impact(.medium)
                            showContact = true
                        }
                        SupportRow(title: "Report a Bug", icon: "exclamationmark.triangle.fill") {
                            HapticManager.shared.impact(.medium)
                            showReportBug = true
                        }
                        SupportRow(title: "Feature Request", icon: "lightbulb.fill") {
                            HapticManager.shared.impact(.medium)
                            showFeatureRequest = true
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.top, AppTheme.Spacing.lg)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .alert("Frequently Asked Questions", isPresented: $showFAQ) {
            Button("OK") { showFAQ = false }
        } message: {
            Text("Q: How do I register a lighter?\nA: Use the Scan QR Code feature to register your lighter.\n\nQ: Can I trade lighters?\nA: Yes! Use the Marketplace tab to browse and trade lighters.\n\nQ: What if I lose my lighter?\nA: Report it in the Lost & Found section.")
        }
        .alert("Contact Us", isPresented: $showContact) {
            Button("OK") { showContact = false }
        } message: {
            Text("Email: support@flick.app\nPhone: 1-800-FLICK\nWe're here to help!")
        }
        .alert("Report a Bug", isPresented: $showReportBug) {
            Button("Cancel") { showReportBug = false }
            Button("Send Report") {
                HapticManager.shared.success()
                showReportBug = false
            }
        } message: {
            Text("Thank you for helping us improve! Your bug report has been submitted.")
        }
        .alert("Feature Request", isPresented: $showFeatureRequest) {
            Button("Cancel") { showFeatureRequest = false }
            Button("Submit") {
                HapticManager.shared.success()
                showFeatureRequest = false
            }
        } message: {
            Text("We'd love to hear your ideas! Your feature request has been submitted to our team.")
        }
    }
}

struct SupportRow: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.medium)
            action()
        }) {
            HStack(spacing: AppTheme.Spacing.md) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(AppTheme.primary)
                    .frame(width: 24)
                
                Text(title)
                    .font(AppTheme.Typography.subheadline)
                    .foregroundColor(AppTheme.textPrimary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(AppTheme.textTertiary)
            }
            .padding(AppTheme.Spacing.md)
            .background(Color.white)
            .cornerRadius(AppTheme.Radius.md)
            .shadow(color: AppTheme.shadowColorLight, radius: 2, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationStack {
        HelpSupportView()
    }
}

