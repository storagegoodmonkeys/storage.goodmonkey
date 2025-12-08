//
//  RegisterView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.dismiss) var dismiss
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showingError = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Back Button
                    HStack {
                        Button(action: {
                            HapticManager.shared.impact(.light)
                            dismiss()
                        }) {
                            HStack(spacing: AppTheme.Spacing.xs) {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .font(AppTheme.Typography.subheadline)
                            .foregroundColor(AppTheme.primary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.top, AppTheme.Spacing.lg)
                    .padding(.bottom, AppTheme.Spacing.sm)
                    
                    // Header
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                        Text("Create Account")
                            .font(AppTheme.Typography.largeTitle)
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Text("Join the Flick community")
                            .font(AppTheme.Typography.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.bottom, AppTheme.Spacing.xl)
                    
                    // Form
                    VStack(spacing: AppTheme.Spacing.lg) {
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            Text("Username")
                                .font(AppTheme.Typography.caption1)
                                .foregroundColor(AppTheme.textPrimary)
                                .fontWeight(.semibold)
                            
                            TextField("Choose a username", text: $username)
                                .textFieldStyle(ModernTextFieldStyle())
                                .autocapitalization(.none)
                        }
                        
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            Text("Email")
                                .font(AppTheme.Typography.caption1)
                                .foregroundColor(AppTheme.textPrimary)
                                .fontWeight(.semibold)
                            
                            TextField("your@email.com", text: $email)
                                .textFieldStyle(ModernTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                        
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            Text("Password")
                                .font(AppTheme.Typography.caption1)
                                .foregroundColor(AppTheme.textPrimary)
                                .fontWeight(.semibold)
                            
                            SecureField("••••••••", text: $password)
                                .textFieldStyle(ModernTextFieldStyle())
                        }
                        
                        Button(action: {
                            HapticManager.shared.impact(.medium)
                            signUp()
                        }) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                } else {
                                    Text("Create Account")
                                        .font(AppTheme.Typography.headline)
                                }
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: AppTheme.Button.height)
                            .background(AppTheme.primary)
                            .cornerRadius(AppTheme.Radius.button)
                        }
                        .disabled(isLoading || username.isEmpty || email.isEmpty || password.isEmpty)
                        .opacity((isLoading || username.isEmpty || email.isEmpty || password.isEmpty) ? 0.6 : 1.0)
                        .padding(.top, AppTheme.Spacing.md)
                        
                        // Sign in with Apple
                        SignInWithAppleButton {
                            authManager.signInWithApple()
                            if authManager.isAuthenticated {
                                appState.signIn(user: authManager.currentUser ?? MockData.shared.currentUser)
                            }
                        }
                        
                        Button(action: {
                            HapticManager.shared.impact(.medium)
                            HapticManager.shared.error()
                            // Google sign in requires Supabase OAuth configuration
                            // Show alert that it needs to be configured
                            errorMessage = "Google Sign In requires OAuth setup in Supabase. Please use email/password or Apple Sign In for now."
                            showingError = true
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
                        
                        HStack {
                            Text("Already have an account?")
                                .font(AppTheme.Typography.caption1)
                                .foregroundColor(AppTheme.textSecondary)
                            
                            NavigationLink(destination: LoginView()) {
                                Text("Sign In")
                                    .font(AppTheme.Typography.caption1)
                                    .fontWeight(.semibold)
                                    .foregroundColor(AppTheme.primary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, AppTheme.Spacing.sm)
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.bottom, AppTheme.Spacing.xl)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .alert("Error", isPresented: $showingError) {
            Button("OK") {
                showingError = false
            }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func signUp() {
        // Validate email format
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email address"
            showingError = true
            return
        }
        
        // Validate password
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters"
            showingError = true
            return
        }
        
        // Validate username
        guard username.count >= 3 else {
            errorMessage = "Username must be at least 3 characters"
            showingError = true
            return
        }
        
        isLoading = true
        authManager.signUp(email: email, username: username, password: password) { success, message in
            isLoading = false
            if success {
                HapticManager.shared.success()
                // Immediate sign in (no email verification required for testing)
                appState.signIn(user: authManager.currentUser ?? MockData.shared.currentUser)
            } else {
                HapticManager.shared.error()
                errorMessage = message ?? "Registration failed"
                showingError = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        RegisterView()
            .environmentObject(AppState())
            .environmentObject(AuthenticationManager())
    }
}
