//
//  LoginView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.dismiss) var dismiss
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
                        Text("Sign In")
                            .font(AppTheme.Typography.largeTitle)
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Text("Welcome back to Flick")
                            .font(AppTheme.Typography.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.bottom, AppTheme.Spacing.xl)
                    
                    // Form
                    VStack(spacing: AppTheme.Spacing.lg) {
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
                            HapticManager.shared.impact(.light)
                            // Handle forgot password
                        }) {
                            Text("Forgot Password?")
                                .font(AppTheme.Typography.caption1)
                                .foregroundColor(AppTheme.primary)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top, -AppTheme.Spacing.sm)
                        
                        Button(action: {
                            HapticManager.shared.impact(.medium)
                            signIn()
                        }) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                } else {
                                    Text("Sign In")
                                        .font(AppTheme.Typography.headline)
                                }
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: AppTheme.Button.height)
                            .background(AppTheme.primary)
                            .cornerRadius(AppTheme.Radius.button)
                        }
                        .disabled(isLoading || email.isEmpty || password.isEmpty)
                        .opacity((isLoading || email.isEmpty || password.isEmpty) ? 0.6 : 1.0)
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
                            Text("Don't have an account?")
                                .font(AppTheme.Typography.caption1)
                                .foregroundColor(AppTheme.textSecondary)
                            
                            NavigationLink(destination: RegisterView()) {
                                Text("Sign Up")
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
    
    private func signIn() {
        isLoading = true
        authManager.signIn(email: email, password: password) { success, error in
            isLoading = false
            if success {
                HapticManager.shared.success()
                appState.signIn(user: authManager.currentUser ?? MockData.shared.currentUser)
            } else {
                HapticManager.shared.error()
                errorMessage = error ?? "Sign in failed"
                showingError = true
            }
        }
    }
}

struct ModernTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(AppTheme.Spacing.md)
            .background(AppTheme.background)
            .cornerRadius(AppTheme.Radius.sm)
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.Radius.sm)
                    .stroke(AppTheme.border, lineWidth: 1)
            )
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AppState())
            .environmentObject(AuthenticationManager())
    }
}
