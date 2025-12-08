//
//  AuthView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    // Logo Section - Original size
                    VStack(spacing: AppTheme.Spacing.md) {
                        Image("Flick_Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .cornerRadius(AppTheme.Radius.sm)
                        
                        Image("Logotype")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                    }
                    .padding(.top, AppTheme.Spacing.xxl)
                    .padding(.bottom, AppTheme.Spacing.xl)
                    
                    VStack(spacing: AppTheme.Spacing.sm) {
                        Text("Welcome to Flick")
                            .font(AppTheme.Typography.largeTitle)
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Text("Never lose your lighter again. Track, trade, and collect unique lighters.")
                            .font(AppTheme.Typography.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, AppTheme.Spacing.xl)
                    }
                    .padding(.bottom, AppTheme.Spacing.xl)
                    
                    Spacer()
                    
                    // Buttons
                    VStack(spacing: AppTheme.Spacing.sm) {
                        NavigationLink(destination: LoginView()) {
                            Text("Sign In")
                                .font(AppTheme.Typography.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: AppTheme.Button.height)
                                .background(AppTheme.primary)
                                .cornerRadius(AppTheme.Radius.button)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            HapticManager.shared.impact(.light)
                        })
                        
                        NavigationLink(destination: RegisterView()) {
                            Text("Create Account")
                                .font(AppTheme.Typography.headline)
                                .foregroundColor(AppTheme.primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: AppTheme.Button.height)
                                .background(AppTheme.background)
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppTheme.Radius.button)
                                        .stroke(AppTheme.primary, lineWidth: 1.5)
                                )
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            HapticManager.shared.impact(.light)
                        })
                        
                        HStack {
                            Rectangle()
                                .fill(AppTheme.border)
                                .frame(height: 1)
                            
                            Text("or")
                                .font(AppTheme.Typography.caption1)
                                .foregroundColor(AppTheme.textSecondary)
                                .padding(.horizontal, AppTheme.Spacing.md)
                            
                            Rectangle()
                                .fill(AppTheme.border)
                                .frame(height: 1)
                        }
                        .padding(.vertical, AppTheme.Spacing.sm)
                        
                        // Sign in with Apple (REQUIRED by Apple)
                        SignInWithAppleButton {
                            authManager.signInWithApple()
                        }
                        .onChange(of: authManager.isAuthenticated) { _, isAuth in
                            if isAuth {
                                appState.signIn(user: authManager.currentUser ?? MockData.shared.currentUser)
                            }
                        }
                        
                        Button(action: {
                            HapticManager.shared.impact(.medium)
                            HapticManager.shared.error()
                            // Google sign in requires OAuth setup
                            // Show alert or handle gracefully
                        }) {
                            HStack {
                                Image(systemName: "globe")
                                Text("Continue with Google")
                                    .font(AppTheme.Typography.subheadline)
                            }
                            .foregroundColor(AppTheme.textPrimary)
                            .frame(maxWidth: .infinity)
                            .frame(height: AppTheme.Button.height)
                            .background(AppTheme.background)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppTheme.Radius.button)
                                    .stroke(AppTheme.border, lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    
                    Text("By continuing, you agree to Flick's Terms of Service and Privacy Policy")
                        .font(AppTheme.Typography.caption2)
                        .foregroundColor(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppTheme.Spacing.xl)
                        .padding(.top, AppTheme.Spacing.md)
                        .padding(.bottom, AppTheme.Spacing.xl)
                }
            }
        }
    }
}

#Preview {
    AuthView()
        .environmentObject(AppState())
        .environmentObject(AuthenticationManager())
}
