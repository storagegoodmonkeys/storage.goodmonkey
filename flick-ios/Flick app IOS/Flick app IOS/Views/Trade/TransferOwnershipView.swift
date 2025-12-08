//
//  TransferOwnershipView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct TransferOwnershipView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedLighters: Set<String> = []
    @State private var searchText = ""
    @State private var selectedRecipient: String? = nil
    @State private var comment = ""
    
    let mockData = MockData.shared
    
    var filteredLighters: [Lighter] {
        mockData.lighters
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.lg) {
                    // Header
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18))
                                .foregroundColor(AppTheme.textPrimary)
                        }
                        
                        Spacer()
                        
                        Text("Transfer Ownership")
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
                    
                    // Select Lighter Section
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                        Text("Select Lighter")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(.horizontal, AppTheme.Spacing.lg)
                        
                        // Grid of Lighters
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: AppTheme.Spacing.sm),
                                GridItem(.flexible(), spacing: AppTheme.Spacing.sm),
                                GridItem(.flexible(), spacing: AppTheme.Spacing.sm)
                            ],
                            spacing: AppTheme.Spacing.sm
                        ) {
                            ForEach(Array(filteredLighters.prefix(6).enumerated()), id: \.element.id) { index, lighter in
                                Button(action: {
                                    if selectedLighters.contains(lighter.id) {
                                        selectedLighters.remove(lighter.id)
                                    } else {
                                        selectedLighters.insert(lighter.id)
                                    }
                                }) {
                                    VStack(spacing: AppTheme.Spacing.xs) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white)
                                                .frame(height: 100)
                                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                                            
                                            // ONE Lighter design
                                            LighterImageView(lighter: lighter, index: index)
                                                .frame(height: 100)
                                                .scaleEffect(0.6)
                                                .padding(8)
                                        }
                                        
                                        Text(lighter.brand ?? "Unknown")
                                            .font(.system(size: 11, weight: .medium))
                                            .foregroundColor(AppTheme.textPrimary)
                                            .lineLimit(1)
                                    }
                                    .padding(8)
                                    .background(Color.white)
                                    .cornerRadius(AppTheme.Radius.sm)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppTheme.Radius.sm)
                                            .stroke(
                                                selectedLighters.contains(lighter.id) ? 
                                                Color.blue : Color.clear,
                                                lineWidth: 2
                                            )
                                    )
                                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, AppTheme.Spacing.lg)
                    }
                    .padding(.top, AppTheme.Spacing.md)
                    
                    Divider()
                        .background(AppTheme.border)
                        .padding(.horizontal, AppTheme.Spacing.lg)
                    
                    // Choose Recipient Section
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                        Text("Choose Recipient")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(.horizontal, AppTheme.Spacing.lg)
                        
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 14))
                                .foregroundColor(AppTheme.textSecondary)
                            
                            TextField("Search for user...", text: $searchText)
                                .font(.system(size: 14))
                                .foregroundColor(AppTheme.textPrimary)
                        }
                        .padding(AppTheme.Spacing.md)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(AppTheme.Radius.sm)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppTheme.Radius.sm)
                                .stroke(AppTheme.border, lineWidth: 1)
                        )
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        
                        // Recipient List
                        VStack(spacing: AppTheme.Spacing.sm) {
                            ForEach(0..<2) { index in
                                Button(action: {
                                    selectedRecipient = "recipient\(index)"
                                }) {
                                    HStack(spacing: AppTheme.Spacing.md) {
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
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(AppTheme.textPrimary)
                                            
                                            Text("Uni s o oiidtage")
                                                .font(.system(size: 12))
                                                .foregroundColor(AppTheme.textSecondary)
                                        }
                                        
                                        Spacer()
                                        
                                        if selectedRecipient == "recipient\(index)" {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.system(size: 20))
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    .padding(AppTheme.Spacing.md)
                                    .background(Color.white)
                                    .cornerRadius(AppTheme.Radius.sm)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppTheme.Radius.sm)
                                            .stroke(
                                                selectedRecipient == "recipient\(index)" ? 
                                                Color.blue : Color.clear,
                                                lineWidth: 2
                                            )
                                    )
                                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, AppTheme.Spacing.lg)
                    }
                    .padding(.top, AppTheme.Spacing.md)
                    
                    Divider()
                        .background(AppTheme.border)
                        .padding(.horizontal, AppTheme.Spacing.lg)
                    
                    // Add Comments Section
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                        TextField("Add comments...", text: $comment, axis: .vertical)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(AppTheme.Spacing.md)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(AppTheme.Radius.sm)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppTheme.Radius.sm)
                                    .stroke(AppTheme.border, lineWidth: 1)
                            )
                            .frame(minHeight: 60)
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.top, AppTheme.Spacing.md)
                    
                    Spacer()
                        .frame(height: 100)
                }
            }
            
            // Transfer Button (Fixed at bottom)
            VStack {
                Spacer()
                Button(action: {
                    HapticManager.shared.impact(.medium)
                    // TODO: Implement transfer ownership with backend
                    HapticManager.shared.success()
                }) {
                    Text("Transfer")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: AppTheme.Button.height)
                        .background(AppTheme.primary)
                        .cornerRadius(AppTheme.Radius.button)
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.bottom, AppTheme.Spacing.lg)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TransferOwnershipView()
}
