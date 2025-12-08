//
//  LostFoundView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI
import Foundation

struct LostFoundView: View {
    @State private var selectedTab = 0
    let mockData = MockData.shared
    
    var lostItems: [LostFound] {
        mockData.lostFound.filter { $0.status == .lost }
    }
    
    var foundItems: [LostFound] {
        mockData.lostFound.filter { $0.status == .found }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Lost & Found")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    
                    Divider()
                        .background(AppTheme.border)
                    
                    // Tabs
                    HStack(spacing: AppTheme.Spacing.sm) {
                        TabButton(
                            title: "Lost (\(lostItems.count))",
                            isSelected: selectedTab == 0
                        ) {
                            selectedTab = 0
                        }
                        
                        TabButton(
                            title: "Found (\(foundItems.count))",
                            isSelected: selectedTab == 1
                        ) {
                            selectedTab = 1
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    
                    // Content
                    if selectedTab == 0 {
                        if lostItems.isEmpty {
                            EmptyLostFoundView(icon: "magnifyingglass", title: "No lost lighters", message: "All lighters are safe!")
                        } else {
                            ScrollView {
                                VStack(spacing: AppTheme.Spacing.md) {
                                    ForEach(lostItems) { item in
                                        LostFoundCard(item: item, isLost: true)
                                    }
                                }
                                .padding(.horizontal, AppTheme.Spacing.lg)
                                .padding(.bottom, AppTheme.Spacing.xl)
                            }
                        }
                    } else {
                        if foundItems.isEmpty {
                            EmptyLostFoundView(icon: "checkmark.circle", title: "No found lighters", message: "Check back later!")
                        } else {
                            ScrollView {
                                VStack(spacing: AppTheme.Spacing.md) {
                                    ForEach(foundItems) { item in
                                        LostFoundCard(item: item, isLost: false)
                                    }
                                }
                                .padding(.horizontal, AppTheme.Spacing.lg)
                                .padding(.bottom, AppTheme.Spacing.xl)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Report Button
                    NavigationLink(destination: ScanView()) {
                        HStack(spacing: AppTheme.Spacing.sm) {
                            Image(systemName: selectedTab == 0 ? "exclamationmark.circle" : "plus.circle")
                                .font(.system(size: 18))
                            Text(selectedTab == 0 ? "Report Lost Lighter" : "Report Found Lighter")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: AppTheme.Button.height)
                        .background(AppTheme.primary)
                        .cornerRadius(AppTheme.Radius.button)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        HapticManager.shared.impact(.medium)
                    })
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.bottom, AppTheme.Spacing.lg)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(isSelected ? .white : AppTheme.textPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppTheme.Spacing.sm)
                .background(isSelected ? AppTheme.primary : Color(red: 0.97, green: 0.97, blue: 0.97))
                .cornerRadius(AppTheme.Radius.md)
        }
    }
}

struct LostFoundCard: View {
    let item: LostFound
    let isLost: Bool
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack(spacing: AppTheme.Spacing.md) {
                Image(systemName: isLost ? "magnifyingglass" : "checkmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(isLost ? AppTheme.warning : AppTheme.success)
                    .frame(width: 40, height: 40)
                    .background((isLost ? AppTheme.warning : AppTheme.success).opacity(0.1))
                    .cornerRadius(AppTheme.Radius.sm)
                
                VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                    Text(isLost ? "Lost Lighter" : "Found Lighter")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Text("QR: \(item.lighterId)")
                        .font(.system(size: 13))
                        .foregroundColor(AppTheme.textSecondary)
                    
                    if let description = item.description {
                        Text(description)
                            .font(.system(size: 14))
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(.top, 4)
                    }
                }
            }
            
            Divider()
                .background(AppTheme.border)
            
            if item.lastLocation != nil {
                HStack(spacing: AppTheme.Spacing.xs) {
                    Image(systemName: "location.fill")
                        .font(.system(size: 10))
                        .foregroundColor(AppTheme.textSecondary)
                    Text("Last seen: Central Park, NYC")
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.textSecondary)
                }
            }
            
            Text("Reported: \(item.reportedAt.formatted(date: .abbreviated, time: .omitted))")
                .font(.system(size: 12))
                .foregroundColor(AppTheme.textSecondary)
            
            Button(action: {
                HapticManager.shared.impact(.medium)
                if isLost {
                    alertMessage = "You've marked this lighter as found! The owner will be notified."
                } else {
                    alertMessage = "Claim request sent! Waiting for owner confirmation."
                }
                showingAlert = true
                HapticManager.shared.success()
            }) {
                Text(isLost ? "I Found This!" : "Claim This Lighter")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: AppTheme.Button.height)
                    .background(AppTheme.primary)
                    .cornerRadius(AppTheme.Radius.button)
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(Color.white)
        .cornerRadius(AppTheme.Radius.md)
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.Radius.md)
                .stroke(AppTheme.border, lineWidth: 1)
        )
        .alert("Success", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
}

struct EmptyLostFoundView: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Image(systemName: icon)
                .font(.system(size: 64))
                .foregroundColor(AppTheme.textTertiary)
            
            Text(title)
                .font(AppTheme.Typography.title3)
                .foregroundColor(AppTheme.textPrimary)
            
            Text(message)
                .font(AppTheme.Typography.subheadline)
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xl)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LostFoundView()
}
