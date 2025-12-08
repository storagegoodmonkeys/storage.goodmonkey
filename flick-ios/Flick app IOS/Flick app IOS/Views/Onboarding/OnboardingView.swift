//
//  OnboardingView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentPage = 0
    
    let slides = [
        OnboardingSlide(
            icon: "flame.fill",
            title: "Welcome to Flick",
            description: "Never lose your lighter again. Track, trade, and collect unique lighters with the world's first lighter tracking community.",
            illustration: "WelcomeIllustration"
        ),
        OnboardingSlide(
            icon: "qrcode.viewfinder",
            title: "Scan QR Codes",
            description: "Scan QR codes to instantly register your lighters and track their location in real-time.",
            illustration: "ScanIllustration"
        ),
        OnboardingSlide(
            icon: "arrow.triangle.swap",
            title: "Trade & Collect",
            description: "Trade lighters with collectors worldwide and build an impressive collection of unique pieces.",
            illustration: "TradeIllustration"
        ),
        OnboardingSlide(
            icon: "magnifyingglass",
            title: "Lost & Found",
            description: "Report lost lighters and help others find theirs through our global community network.",
            illustration: "LostFoundIllustration"
        )
    ]
    
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Logo at top - Original size
                HStack {
                    Spacer()
                    VStack(spacing: AppTheme.Spacing.sm) {
                        Image("Flick_Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .cornerRadius(AppTheme.Radius.sm)
                        
                        Image("Logotype")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 32)
                    }
                    Spacer()
                }
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.md)
                
                // Content with TabView
                TabView(selection: $currentPage) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        OnboardingSlideView(slide: slides[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                // Bottom Navigation - Fixed at bottom with proper spacing
                VStack(spacing: 0) {
                    HStack {
                        if currentPage < slides.count - 1 {
                            Button("Skip") {
                                HapticManager.shared.impact(.light)
                                appState.completeOnboarding()
                            }
                            .font(AppTheme.Typography.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                            .padding(.horizontal, AppTheme.Spacing.md)
                            .padding(.vertical, AppTheme.Spacing.sm)
                        } else {
                            Spacer()
                                .frame(width: 80)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            HapticManager.shared.impact(.medium)
                            if currentPage < slides.count - 1 {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                    currentPage += 1
                                }
                            } else {
                                appState.completeOnboarding()
                            }
                        }) {
                            Text(currentPage == slides.count - 1 ? "Get Started" : "Next")
                                .font(AppTheme.Typography.headline)
                                .foregroundColor(.white)
                                .frame(height: AppTheme.Button.height)
                                .padding(.horizontal, AppTheme.Spacing.xl)
                                .background(AppTheme.primary)
                                .cornerRadius(AppTheme.Radius.button)
                        }
                        .padding(.horizontal, AppTheme.Spacing.md)
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    .padding(.bottom, AppTheme.Spacing.lg)
                    .background(Color.white)
                }
            }
        }
    }
}

struct OnboardingSlide {
    let icon: String
    let title: String
    let description: String
    let illustration: String
}

struct OnboardingSlideView: View {
    let slide: OnboardingSlide
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 20)
                
                // Illustration - Reduced size
                ZStack {
                    // Background gradient circle - Smaller
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppTheme.primary.opacity(0.1),
                                    AppTheme.secondary.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 220, height: 220)
                    
                    // Icon with decorative elements - Reduced sizes
                    VStack(spacing: AppTheme.Spacing.sm) {
                        ZStack {
                            // Decorative circles - Smaller
                            Circle()
                                .fill(AppTheme.primary.opacity(0.2))
                                .frame(width: 110, height: 110)
                            
                            Circle()
                                .fill(AppTheme.secondary.opacity(0.2))
                                .frame(width: 80, height: 80)
                            
                            // Main icon - Smaller
                            Image(systemName: slide.icon)
                                .font(.system(size: 44, weight: .medium))
                                .foregroundColor(AppTheme.primary)
                        }
                        
                        // Additional visual elements based on slide
                        if slide.illustration == "ScanIllustration" {
                            HStack(spacing: AppTheme.Spacing.xs) {
                                ForEach(0..<3) { _ in
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(AppTheme.primary.opacity(0.3))
                                        .frame(width: 6, height: 6)
                                }
                            }
                        } else if slide.illustration == "TradeIllustration" {
                            HStack(spacing: AppTheme.Spacing.xs) {
                                Image(systemName: "arrow.left.arrow.right")
                                    .font(.system(size: 14))
                                    .foregroundColor(AppTheme.primary.opacity(0.6))
                                Image(systemName: "arrow.triangle.swap")
                                    .font(.system(size: 14))
                                    .foregroundColor(AppTheme.secondary.opacity(0.6))
                            }
                        } else if slide.illustration == "LostFoundIllustration" {
                            HStack(spacing: AppTheme.Spacing.xs) {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(AppTheme.warning.opacity(0.6))
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(AppTheme.success.opacity(0.6))
                            }
                        }
                    }
                }
                .padding(.bottom, AppTheme.Spacing.xl)
                
                // Content - with proper spacing and FULL text
                VStack(spacing: AppTheme.Spacing.md) {
                    Text(slide.title)
                        .font(AppTheme.Typography.largeTitle)
                        .foregroundColor(AppTheme.textPrimary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppTheme.Spacing.lg)
                    
                    Text(slide.description)
                        .font(AppTheme.Typography.body)
                        .foregroundColor(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, AppTheme.Spacing.xl)
                        .padding(.bottom, 20)
                }
                .padding(.top, AppTheme.Spacing.lg)
                
                Spacer()
                    .frame(height: 100)
            }
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppState())
}
