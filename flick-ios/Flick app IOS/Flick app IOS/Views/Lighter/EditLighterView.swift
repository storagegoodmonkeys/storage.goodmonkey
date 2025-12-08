//
//  EditLighterView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct EditLighterView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var mockData = MockData.shared
    let lighter: Lighter
    
    @State private var brand: String
    @State private var color: String
    @State private var status: LighterStatus
    
    init(lighter: Lighter) {
        self.lighter = lighter
        _brand = State(initialValue: lighter.brand ?? "")
        _color = State(initialValue: lighter.color ?? "")
        _status = State(initialValue: lighter.status)
    }
    
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
                        
                        Text("Edit Lighter")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        Button(action: {
                            HapticManager.shared.success()
                            saveLighter()
                            dismiss()
                        }) {
                            Text("Save")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(AppTheme.primary)
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    
                    Divider()
                        .background(AppTheme.border)
                    
                    // Lighter Preview
                    VStack(spacing: AppTheme.Spacing.md) {
                        let lighterIndex = mockData.lighters.firstIndex(where: { $0.id == lighter.id }) ?? 0
                        LighterImageView(lighter: lighter, index: lighterIndex)
                            .frame(height: 200)
                        
                        Text("QR Code: \(lighter.qrCode)")
                            .font(AppTheme.Typography.caption1)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.top, AppTheme.Spacing.lg)
                    
                    // Form Fields
                    VStack(spacing: AppTheme.Spacing.lg) {
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            Text("Brand")
                                .font(AppTheme.Typography.caption1)
                                .fontWeight(.semibold)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            TextField("Brand name", text: $brand)
                                .textFieldStyle(ModernTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            Text("Color")
                                .font(AppTheme.Typography.caption1)
                                .fontWeight(.semibold)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            TextField("Color", text: $color)
                                .textFieldStyle(ModernTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            Text("Status")
                                .font(AppTheme.Typography.caption1)
                                .fontWeight(.semibold)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Picker("Status", selection: $status) {
                                Text("Owned").tag(LighterStatus.owned)
                                Text("Trading").tag(LighterStatus.trading)
                                Text("Lost").tag(LighterStatus.lost)
                                Text("Found").tag(LighterStatus.found)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.vertical, AppTheme.Spacing.sm)
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.top, AppTheme.Spacing.lg)
                    
                    Spacer()
                        .frame(height: AppTheme.Spacing.xl)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func saveLighter() {
        // Create updated lighter
        let updatedLighter = Lighter(
            id: lighter.id,
            qrCode: lighter.qrCode,
            ownerId: lighter.ownerId,
            brand: brand.isEmpty ? nil : brand,
            color: color.isEmpty ? nil : color,
            photoUrl: lighter.photoUrl,
            status: status,
            registeredAt: lighter.registeredAt,
            currentLocation: lighter.currentLocation
        )
        
        // Update in MockData (which syncs to Supabase)
        mockData.updateLighter(updatedLighter)
    }
}

#Preview {
    NavigationStack {
        EditLighterView(lighter: MockData.shared.lighters[0])
    }
}

