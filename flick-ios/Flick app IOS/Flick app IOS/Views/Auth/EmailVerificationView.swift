//
//  EmailVerificationView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct EmailVerificationView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.dismiss) var dismiss
    
    let email: String
    let username: String
    
    @State private var verificationCode = ""
    @State private var isLoading = false
    @State private var showingError = false
    @State private var errorMessage = ""
    @State private var timeRemaining = 60
    @State private var timer: Timer?
    @State private var canResend = false
    
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
                    VStack(spacing: AppTheme.Spacing.md) {
                        Image(systemName: "envelope.badge.fill")
                            .font(.system(size: 64))
                            .foregroundColor(AppTheme.primary)
                        
                        Text("Verify Your Email")
                            .font(AppTheme.Typography.largeTitle)
                            .foregroundColor(AppTheme.textPrimary)
                        
                        VStack(spacing: AppTheme.Spacing.xs) {
                            Text("We sent a verification code to")
                                .font(AppTheme.Typography.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                            
                            Text(email)
                                .font(AppTheme.Typography.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(AppTheme.primary)
                        }
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppTheme.Spacing.xl)
                    }
                    .padding(.top, AppTheme.Spacing.xl)
                    .padding(.bottom, AppTheme.Spacing.xl)
                    
                    // Code Input
                    VStack(spacing: AppTheme.Spacing.lg) {
                        Text("Enter Verification Code")
                            .font(AppTheme.Typography.headline)
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(.bottom, AppTheme.Spacing.xs)
                        
                        // 6-digit code input
                        HStack(spacing: AppTheme.Spacing.sm) {
                            ForEach(0..<6) { index in
                                CodeDigitView(
                                    digit: codeDigit(at: index),
                                    isFocused: verificationCode.count == index,
                                    onDigitChange: { newDigit in
                                        updateCode(at: index, with: newDigit)
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        
                        // Verify Button
                        Button(action: {
                            HapticManager.shared.impact(.medium)
                            verifyCode()
                        }) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                } else {
                                    Text("Verify Email")
                                        .font(AppTheme.Typography.headline)
                                }
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: AppTheme.Button.height)
                            .background(AppTheme.primary)
                            .cornerRadius(AppTheme.Radius.button)
                        }
                        .disabled(isLoading || verificationCode.count != 6)
                        .opacity((isLoading || verificationCode.count != 6) ? 0.6 : 1.0)
                        .padding(.top, AppTheme.Spacing.md)
                        
                        // Resend Code
                        VStack(spacing: AppTheme.Spacing.xs) {
                            if canResend {
                                Button(action: {
                                    HapticManager.shared.impact(.light)
                                    resendCode()
                                }) {
                                    Text("Resend Code")
                                        .font(AppTheme.Typography.subheadline)
                                        .foregroundColor(AppTheme.primary)
                                        .fontWeight(.semibold)
                                }
                            } else {
                                Text("Resend code in \(timeRemaining)s")
                                    .font(AppTheme.Typography.caption1)
                                    .foregroundColor(AppTheme.textSecondary)
                            }
                        }
                        .padding(.top, AppTheme.Spacing.sm)
                        
                        Text("Didn't receive the code? Check your spam folder or try resending.")
                            .font(AppTheme.Typography.caption2)
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, AppTheme.Spacing.lg)
                            .padding(.top, AppTheme.Spacing.xs)
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.bottom, AppTheme.Spacing.xl)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
        .alert("Error", isPresented: $showingError) {
            Button("OK") {
                showingError = false
            }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func codeDigit(at index: Int) -> String {
        if index < verificationCode.count {
            return String(verificationCode[verificationCode.index(verificationCode.startIndex, offsetBy: index)])
        }
        return ""
    }
    
    private func updateCode(at index: Int, with digit: String) {
        if digit.isEmpty {
            // Delete
            if verificationCode.count > index {
                verificationCode = String(verificationCode.prefix(index))
            } else if verificationCode.count == index && !verificationCode.isEmpty {
                verificationCode = String(verificationCode.prefix(verificationCode.count - 1))
            }
        } else if digit.count == 1 && digit.allSatisfy({ $0.isNumber }) {
            // Add digit
            if verificationCode.count <= index {
                verificationCode += digit
            } else {
                var codeArray = Array(verificationCode)
                codeArray[index] = Character(digit)
                verificationCode = String(codeArray)
            }
            
            // Auto-focus next field if not last
            if verificationCode.count < 6 && verificationCode.count == index + 1 {
                // Focus moves automatically via isFocused binding
            }
        }
    }
    
    private func verifyCode() {
        guard verificationCode.count == 6 else {
            errorMessage = "Please enter the 6-digit code"
            showingError = true
            return
        }
        
        isLoading = true
        authManager.verifyEmailOTP(email: email, code: verificationCode) { success, message in
            isLoading = false
            if success {
                HapticManager.shared.success()
                // User is already signed in after verification
                appState.signIn(user: authManager.currentUser ?? MockData.shared.currentUser)
            } else {
                HapticManager.shared.error()
                errorMessage = message ?? "Invalid verification code. Please try again."
                showingError = true
                verificationCode = "" // Clear code on error
            }
        }
    }
    
    private func resendCode() {
        isLoading = true
        authManager.resendVerificationCode(email: email) { success, message in
            isLoading = false
            if success {
                HapticManager.shared.success()
                verificationCode = ""
                canResend = false
                timeRemaining = 60
                startTimer()
            } else {
                errorMessage = message ?? "Failed to resend code. Please try again."
                showingError = true
            }
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        canResend = false
        timeRemaining = 60
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                canResend = true
                timer?.invalidate()
            }
        }
    }
}

// MARK: - Code Digit View
struct CodeDigitView: View {
    let digit: String
    let isFocused: Bool
    let onDigitChange: (String) -> Void
    
    var body: some View {
        TextField("", text: Binding(
            get: { digit },
            set: { onDigitChange($0) }
        ))
        .keyboardType(.numberPad)
        .multilineTextAlignment(.center)
        .font(.system(size: 24, weight: .bold, design: .rounded))
        .foregroundColor(AppTheme.textPrimary)
        .frame(width: 50, height: 60)
        .background(AppTheme.background)
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.Radius.sm)
                .stroke(isFocused ? AppTheme.primary : AppTheme.border, lineWidth: isFocused ? 2 : 1)
        )
        .cornerRadius(AppTheme.Radius.sm)
    }
}

#Preview {
    NavigationStack {
        EmailVerificationView(email: "test@example.com", username: "testuser")
            .environmentObject(AppState())
            .environmentObject(AuthenticationManager())
    }
}

