//
//  ProposeTradeView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct ProposeTradeView: View {
    @Environment(\.dismiss) var dismiss
    let lighterOffered: Lighter
    let lighterRequested: Lighter
    @State private var comment = ""
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: AppTheme.Spacing.lg) {
                    // Header
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18))
                                .foregroundColor(AppTheme.textPrimary)
                        }
                        
                        Spacer()
                        
                        Text("Propose a Trade")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        Button(action: {
                            HapticManager.shared.impact(.light)
                            // TODO: Implement search functionality
                        }) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 18))
                                .foregroundColor(AppTheme.textPrimary)
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    
                    Divider()
                        .background(AppTheme.border)
                    
                    // Trade Offers - Side by Side
                    HStack(spacing: AppTheme.Spacing.md) {
                        // Your Offer
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                            Text("Your Offer")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(AppTheme.textPrimary)
                            
                            // User Profile
                            HStack(spacing: AppTheme.Spacing.sm) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                                        .frame(width: 40, height: 40)
                                    
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Clipmen")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(AppTheme.textPrimary)
                                    
                                    Text("Unls o Diidtage")
                                        .font(.system(size: 11))
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                            }
                            
                            // Lighter Card
                            LighterTradeCard(
                                lighter: lighterOffered,
                                index: MockData.shared.lighters.firstIndex(where: { $0.id == lighterOffered.id }) ?? 0
                            )
                        }
                        
                        // Recipient's Offer
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                            Text("Recipient's Offer")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(AppTheme.textPrimary)
                            
                            // User Profile
                            HStack(spacing: AppTheme.Spacing.sm) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                                        .frame(width: 40, height: 40)
                                    
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Clipmen")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(AppTheme.textPrimary)
                                    
                                    Text("Unlso niicitaga")
                                        .font(.system(size: 11))
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                            }
                            
                            // Lighter Card
                            LighterTradeCard(
                                lighter: lighterRequested,
                                index: MockData.shared.marketplaceLighters.firstIndex(where: { $0.id == lighterRequested.id }) ?? 0
                            )
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.top, AppTheme.Spacing.md)
                    
                    Divider()
                        .background(AppTheme.border)
                        .padding(.horizontal, AppTheme.Spacing.lg)
                    
                    // Trade Details
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                        Text("Trade Details")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(.horizontal, AppTheme.Spacing.lg)
                        
                        TextField("Add comments", text: $comment, axis: .vertical)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(AppTheme.Spacing.md)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(AppTheme.Radius.sm)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppTheme.Radius.sm)
                                    .stroke(AppTheme.border, lineWidth: 1)
                            )
                            .padding(.horizontal, AppTheme.Spacing.lg)
                            .frame(minHeight: 60)
                    }
                    .padding(.top, AppTheme.Spacing.md)
                    
                    Spacer()
                        .frame(height: 100)
                }
            }
            
            // Confirm Trade Button (Fixed at bottom)
            VStack {
                Spacer()
                Button(action: {
                    HapticManager.shared.impact(.medium)
                    // TODO: Implement trade confirmation with backend
                    HapticManager.shared.success()
                }) {
                    Text("Confirm Trade")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: AppTheme.Button.height)
                        .background(Color(red: 0.3, green: 0.3, blue: 0.3))
                        .cornerRadius(AppTheme.Radius.button)
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.bottom, AppTheme.Spacing.lg)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct LighterTradeCard: View {
    let lighter: Lighter
    let index: Int
    
    var body: some View {
        VStack(spacing: AppTheme.Spacing.xs) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(height: 140)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                
                // ONE Lighter design
                LighterImageView(lighter: lighter, index: index)
                    .frame(height: 140)
                    .scaleEffect(0.7)
                    .padding(8)
            }
            
            Text(lighter.brand ?? "Unknown")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
        }
        .background(Color.white)
        .cornerRadius(AppTheme.Radius.md)
    }
}

#Preview {
    ProposeTradeView(
        lighterOffered: MockData.shared.lighters[0],
        lighterRequested: MockData.shared.marketplaceLighters[0]
    )
}
