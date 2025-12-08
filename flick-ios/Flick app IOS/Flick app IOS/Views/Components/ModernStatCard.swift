//
//  ModernStatCard.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct ModernStatCard: View {
    let number: String
    let label: String
    let icon: String
    
    var body: some View {
        VStack(spacing: AppTheme.Spacing.xs) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(AppTheme.primary)
            
            Text(number)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(AppTheme.textPrimary)
            
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppTheme.Spacing.md)
        .background(Color.white)
        .cornerRadius(AppTheme.Radius.md)
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.Radius.md)
                .stroke(AppTheme.border, lineWidth: 1)
        )
    }
}

#Preview {
    HStack {
        ModernStatCard(number: "42", label: "Lighters", icon: "flame.fill")
        ModernStatCard(number: "1250", label: "Points", icon: "star.fill")
        ModernStatCard(number: "Silver", label: "Level", icon: "trophy.fill")
    }
    .padding()
}


