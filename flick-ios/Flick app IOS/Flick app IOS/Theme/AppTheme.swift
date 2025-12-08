//
//  AppTheme.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct AppTheme {
    // Primary Colors - Red
    static let primary = Color(red: 255/255, green: 107/255, blue: 53/255) // #ff6b35
    static let primaryDark = Color(red: 232/255, green: 84/255, blue: 36/255) // #e85424
    static let primaryLight = Color(red: 255/255, green: 140/255, blue: 96/255) // #ff8c60
    
    // Secondary Colors - Yellow/Orange
    static let secondary = Color(red: 255/255, green: 210/255, blue: 63/255) // #ffd23f
    static let accent = Color(red: 255/255, green: 65/255, blue: 108/255) // #ff416c
    
    // Neutral Backgrounds - White family
    static let background = Color.white
    static let backgroundSecondary = Color(red: 249/255, green: 250/255, blue: 251/255) // #f9fafb
    static let backgroundTertiary = Color(red: 243/255, green: 244/255, blue: 246/255) // #f3f4f6
    
    // Text Colors
    static let textPrimary = Color(red: 17/255, green: 24/255, blue: 39/255) // #111827
    static let textSecondary = Color(red: 107/255, green: 114/255, blue: 128/255) // #6b7280
    static let textTertiary = Color(red: 156/255, green: 163/255, blue: 175/255) // #9ca3af
    
    // Status Colors
    static let success = Color(red: 34/255, green: 197/255, blue: 94/255) // #22c55e
    static let error = Color(red: 239/255, green: 68/255, blue: 68/255) // #ef4444
    static let warning = Color(red: 245/255, green: 158/255, blue: 11/255) // #f59e0b
    static let info = Color(red: 59/255, green: 130/255, blue: 246/255) // #3b82f6
    
    // Border & Divider
    static let border = Color(red: 229/255, green: 231/255, blue: 235/255) // #e5e7eb
    static let divider = Color(red: 229/255, green: 231/255, blue: 235/255) // #e5e7eb
    
    // Shadows
    static let shadowColor = Color.black.opacity(0.08)
    static let shadowColorLight = Color.black.opacity(0.04)
    
    // Gradients
    static let gradientFire = LinearGradient(
        colors: [accent, primary, secondary],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let gradientRed = LinearGradient(
        colors: [accent, primary],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    // Typography
    struct Typography {
        static let largeTitle = Font.system(size: 34, weight: .bold)
        static let title1 = Font.system(size: 28, weight: .bold)
        static let title2 = Font.system(size: 22, weight: .semibold)
        static let title3 = Font.system(size: 20, weight: .semibold)
        static let headline = Font.system(size: 17, weight: .semibold)
        static let body = Font.system(size: 17, weight: .regular)
        static let callout = Font.system(size: 16, weight: .regular)
        static let subheadline = Font.system(size: 15, weight: .regular)
        static let footnote = Font.system(size: 13, weight: .regular)
        static let caption1 = Font.system(size: 12, weight: .regular)
        static let caption2 = Font.system(size: 11, weight: .regular)
    }
    
    // Spacing
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }
    
    // Corner Radius - Reduced and standardized
    struct Radius {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8      // Small buttons
        static let md: CGFloat = 10     // Standard buttons (reduced from 12)
        static let lg: CGFloat = 12     // Cards (reduced from 16)
        static let xl: CGFloat = 16     // Large cards (reduced from 20)
        static let button: CGFloat = 10 // Consistent button radius
    }
    
    // Button Heights - Reduced
    struct Button {
        static let height: CGFloat = 44  // Standard button height (reduced)
        static let heightSmall: CGFloat = 36  // Small button height
    }
}

// Card Style Modifier
struct ModernCardStyle: ViewModifier {
    var backgroundColor: Color = AppTheme.background
    
    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .cornerRadius(AppTheme.Radius.lg)
            .shadow(color: AppTheme.shadowColorLight, radius: 8, x: 0, y: 2)
    }
}

extension View {
    func modernCard(backgroundColor: Color = AppTheme.background) -> some View {
        modifier(ModernCardStyle(backgroundColor: backgroundColor))
    }
}

// Standard Button Style
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTheme.Typography.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: AppTheme.Button.height)
            .background(AppTheme.primary)
            .cornerRadius(AppTheme.Radius.button)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTheme.Typography.headline)
            .foregroundColor(AppTheme.primary)
            .frame(maxWidth: .infinity)
            .frame(height: AppTheme.Button.height)
            .background(AppTheme.background)
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.Radius.button)
                    .stroke(AppTheme.primary, lineWidth: 1.5)
            )
            .cornerRadius(AppTheme.Radius.button)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}
