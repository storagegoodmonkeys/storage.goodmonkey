//
//  CollectionView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI
import Foundation

struct CollectionView: View {
    @ObservedObject var mockData = MockData.shared
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    
    var filteredLighters: [Lighter] {
        if searchText.isEmpty {
            return mockData.lighters
        }
        return mockData.lighters.filter { lighter in
            (lighter.brand?.localizedCaseInsensitiveContains(searchText) ?? false) ||
            lighter.qrCode.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        // Back button - always show
                        Button(action: {
                            HapticManager.shared.impact(.light)
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(AppTheme.textPrimary)
                        }
                        
                        Spacer()
                        
                        Text("Clipper Vault")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        Button(action: {
                            HapticManager.shared.impact(.medium)
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
                    
                    // Collection Count
                    HStack {
                        Text("Collection: \(filteredLighters.count) Lighters")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    
                    // Grid Layout - Fill available space properly
                    if filteredLighters.isEmpty {
                        Spacer()
                        EmptyCollectionView()
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible(), spacing: AppTheme.Spacing.md),
                                    GridItem(.flexible(), spacing: AppTheme.Spacing.md)
                                ],
                                spacing: AppTheme.Spacing.lg
                            ) {
                                ForEach(Array(filteredLighters.enumerated()), id: \.element.id) { index, lighter in
                                    NavigationLink(destination: LighterDetailView(lighter: lighter)) {
                                        CollectionGridCard(
                                            lighter: lighter,
                                            index: index
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, AppTheme.Spacing.lg)
                            .padding(.top, AppTheme.Spacing.sm)
                            .padding(.bottom, 120) // Extra padding for floating button
                        }
                    }
                }
                
                // Add New Lighter Button (Floating at bottom)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: ScanView()) {
                            HStack(spacing: AppTheme.Spacing.sm) {
                                Image(systemName: "plus")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("Add New Lighter")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, AppTheme.Spacing.lg)
                            .frame(height: AppTheme.Button.height)
                            .background(Color.black)
                            .cornerRadius(AppTheme.Radius.button)
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            HapticManager.shared.impact(.medium)
                        })
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        .padding(.bottom, AppTheme.Spacing.lg)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct CollectionGridCard: View {
    let lighter: Lighter
    let index: Int
    
    var body: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            // ONE Lighter Card - Clean and centered
            ZStack {
                RoundedRectangle(cornerRadius: AppTheme.Radius.lg)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 3)
                
                // Single Lighter - Designed programmatically, ONE per card
                LighterImageView(lighter: lighter, index: index)
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .padding(AppTheme.Spacing.md)
            }
            
            // Lighter Name - Below the image
            Text(lighter.brand ?? "Unknown Brand")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
        }
    }
}

struct EmptyCollectionView: View {
    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Image(systemName: "flame")
                .font(.system(size: 64))
                .foregroundColor(AppTheme.textTertiary)
            
            Text("No lighters yet")
                .font(AppTheme.Typography.title3)
                .foregroundColor(AppTheme.textPrimary)
            
            Text("Scan a QR code to add your first lighter!")
                .font(AppTheme.Typography.subheadline)
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xl)
        }
    }
}

#Preview {
    CollectionView()
}
