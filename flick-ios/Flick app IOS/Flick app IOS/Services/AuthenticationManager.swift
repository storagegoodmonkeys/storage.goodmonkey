//
//  AuthenticationManager.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import Foundation
import AuthenticationServices
import SwiftUI

class AuthenticationManager: NSObject, ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    private let supabaseService = SupabaseService.shared
    
    func signIn(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        // Validate email format
        guard email.contains("@") && email.contains(".") else {
            completion(false, "Please enter a valid email address")
            return
        }
        
        // Validate password not empty
        guard !password.isEmpty else {
            completion(false, "Password cannot be empty")
            return
        }
        
        Task {
            do {
                let user = try await supabaseService.signIn(email: email, password: password)
                await MainActor.run {
                    self.isAuthenticated = true
                    self.currentUser = user
                    UserDefaults.standard.set(true, forKey: "isAuthenticated")
                    UserDefaults.standard.set(user.id, forKey: "current_user_id")
                    HapticManager.shared.success()
                    completion(true, nil)
                }
            } catch {
                await MainActor.run {
                    HapticManager.shared.error()
                    let errorMessage = error.localizedDescription.contains("Invalid login") || error.localizedDescription.contains("email not confirmed")
                        ? "Invalid email or password. Please check your credentials."
                        : error.localizedDescription
                    completion(false, errorMessage)
                }
            }
        }
    }
    
    func signUp(email: String, username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        // Validate email format
        guard email.contains("@") && email.contains(".") else {
            completion(false, "Please enter a valid email address")
            return
        }
        
        // Validate password strength
        guard password.count >= 6 else {
            completion(false, "Password must be at least 6 characters")
            return
        }
        
        // Validate username
        guard !username.isEmpty && username.count >= 3 else {
            completion(false, "Username must be at least 3 characters")
            return
        }
        
        Task {
            do {
                // Sign up and immediately sign in (no email verification required for testing)
                let user = try await supabaseService.signUp(email: email, password: password, username: username)
                
                // Immediately sign in the user
                await MainActor.run {
                    self.isAuthenticated = true
                    self.currentUser = user
                    UserDefaults.standard.set(true, forKey: "isAuthenticated")
                    UserDefaults.standard.set(user.id, forKey: "current_user_id")
                    HapticManager.shared.success()
                    completion(true, "Account created successfully!")
                }
            } catch {
                await MainActor.run {
                    HapticManager.shared.error()
                    let errorMessage = error.localizedDescription.contains("already registered") || error.localizedDescription.contains("already exists")
                        ? "This email is already registered. Please sign in instead."
                        : error.localizedDescription
                    completion(false, errorMessage)
                }
            }
        }
    }
    
    func verifyEmailOTP(email: String, token: String, type: String, completion: @escaping (Bool, String?) -> Void) {
        Task {
            do {
                // Verify OTP
                let user = try await supabaseService.verifyOTP(email: email, token: token, type: type)
                
                // After verification, complete signup with stored credentials if available
                if let storedEmail = UserDefaults.standard.string(forKey: "pending_signup_email"),
                   let storedUsername = UserDefaults.standard.string(forKey: "pending_signup_username"),
                   let storedPassword = UserDefaults.standard.string(forKey: "pending_signup_password"),
                   storedEmail == email {
                    // Create user profile with username
                    do {
                        try await supabaseService.updateUserProfile(User(
                            id: user.id,
                            email: user.email ?? storedEmail,
                            username: storedUsername,
                            avatarUrl: user.avatarUrl,
                            bio: user.bio,
                            location: user.location,
                            points: user.points,
                            level: user.level,
                            createdAt: user.createdAt
                        ))
                        
                        // Clear stored credentials
                        UserDefaults.standard.removeObject(forKey: "pending_signup_email")
                        UserDefaults.standard.removeObject(forKey: "pending_signup_username")
                        UserDefaults.standard.removeObject(forKey: "pending_signup_password")
                        
                        await MainActor.run {
                            self.isAuthenticated = true
                            self.currentUser = User(
                                id: user.id,
                                email: user.email ?? storedEmail,
                                username: storedUsername,
                                avatarUrl: user.avatarUrl,
                                bio: user.bio,
                                location: user.location,
                                points: user.points,
                                level: user.level,
                                createdAt: user.createdAt
                            )
                            UserDefaults.standard.set(true, forKey: "isAuthenticated")
                            UserDefaults.standard.set(self.currentUser!.id, forKey: "current_user_id")
                            HapticManager.shared.success()
                            completion(true, "Email verified successfully!")
                        }
                    } catch {
                        // Profile update failed, but verification succeeded
                        await MainActor.run {
                            self.isAuthenticated = true
                            self.currentUser = user
                            UserDefaults.standard.set(true, forKey: "isAuthenticated")
                            UserDefaults.standard.set(user.id, forKey: "current_user_id")
                            HapticManager.shared.success()
                            completion(true, "Email verified successfully!")
                        }
                    }
                } else {
                    // Already have user from verification
                    await MainActor.run {
                        self.isAuthenticated = true
                        self.currentUser = user
                        UserDefaults.standard.set(true, forKey: "isAuthenticated")
                        UserDefaults.standard.set(user.id, forKey: "current_user_id")
                        HapticManager.shared.success()
                        completion(true, "Email verified successfully!")
                    }
                }
            } catch {
                await MainActor.run {
                    HapticManager.shared.error()
                    let errorMessage = error.localizedDescription.contains("Invalid") || error.localizedDescription.contains("expired")
                        ? "Invalid or expired verification code. Please try again or request a new code."
                        : error.localizedDescription
                    completion(false, errorMessage)
                }
            }
        }
    }
    
    func resendVerificationCode(email: String, completion: @escaping (Bool, String?) -> Void) {
        Task {
            do {
                try await supabaseService.sendOTP(email: email, type: "signup")
                await MainActor.run {
                    HapticManager.shared.success()
                    completion(true, "Verification code sent successfully!")
                }
            } catch {
                await MainActor.run {
                    HapticManager.shared.error()
                    completion(false, "Failed to resend code. Please try again.")
                }
            }
        }
    }
    
    func signOut() {
        Task {
            do {
                try await supabaseService.signOut()
                await MainActor.run {
                    self.isAuthenticated = false
                    self.currentUser = nil
                    UserDefaults.standard.set(false, forKey: "isAuthenticated")
                }
            } catch {
                print("Sign out error: \(error)")
                // Still sign out locally even if API call fails
                await MainActor.run {
                    self.isAuthenticated = false
                    self.currentUser = nil
                    UserDefaults.standard.set(false, forKey: "isAuthenticated")
                }
            }
        }
    }
    
    func checkAuthentication() {
        Task {
            do {
                if let user = try await supabaseService.getCurrentUser() {
                    await MainActor.run {
                        self.isAuthenticated = true
                        self.currentUser = user
                        UserDefaults.standard.set(user.id, forKey: "current_user_id")
                        print("✅ User authenticated: \(user.email ?? "")")
                    }
                } else {
                    await MainActor.run {
                        self.isAuthenticated = false
                        self.currentUser = nil
                        UserDefaults.standard.removeObject(forKey: "current_user_id")
                    }
                }
            } catch {
                print("Check auth error: \(error)")
                await MainActor.run {
                    self.isAuthenticated = false
                    self.currentUser = nil
                    UserDefaults.standard.removeObject(forKey: "current_user_id")
                }
            }
        }
    }
}

// MARK: - Sign in with Apple
extension AuthenticationManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Handle Apple ID authentication
            let appleUserID = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            var email = appleIDCredential.email
            var username: String
            
            // Apple only provides email on first sign-in, store it for future use
            if let emailFromApple = email {
                // First time sign-in, save email
                UserDefaults.standard.set(emailFromApple, forKey: "apple_user_email_\(appleUserID)")
            } else {
                // Returning user, get email from storage
                email = UserDefaults.standard.string(forKey: "apple_user_email_\(appleUserID)")
            }
            
            // If no email available, we need to create a unique identifier
            let finalEmail = email ?? "apple_\(appleUserID)@privaterelay.appleid.com"
            
            // Get username from name or stored value
            if let name = fullName {
                username = "\(name.givenName ?? "") \(name.familyName ?? "")".trimmingCharacters(in: .whitespaces)
                if username.isEmpty {
                    username = "Apple User"
                }
            } else {
                username = UserDefaults.standard.string(forKey: "apple_user_name_\(appleUserID)") ?? "Apple User"
            }
            
            // Save username for future use
            if !username.isEmpty && username != "Apple User" {
                UserDefaults.standard.set(username, forKey: "apple_user_name_\(appleUserID)")
            }
            
            // Store Apple User ID for future reference
            UserDefaults.standard.set(appleUserID, forKey: "apple_user_id")
            
            print("🍎 Apple Sign In - User ID: \(appleUserID), Email: \(finalEmail), Username: \(username)")
            
            // Try to sign in first (user might already exist)
            Task {
                do {
                    // First, try to sign in with existing credentials
                    // Note: This is a workaround - proper OAuth requires Supabase configuration
                    if let storedEmail = email, let storedPassword = UserDefaults.standard.string(forKey: "apple_user_password_\(appleUserID)") {
                        print("🔐 Attempting sign in with stored credentials")
                        let user = try await supabaseService.signIn(email: storedEmail, password: storedPassword)
                        
                        await MainActor.run {
                            self.isAuthenticated = true
                            self.currentUser = user
                            UserDefaults.standard.set(true, forKey: "isAuthenticated")
                            UserDefaults.standard.set(user.id, forKey: "current_user_id")
                            HapticManager.shared.success()
                            print("✅ Apple Sign In successful (existing user)")
                        }
                        return
                    }
                } catch {
                    print("⚠️ Sign in failed, will try sign up: \(error.localizedDescription)")
                }
                
                // If sign in fails or no stored credentials, try to sign up
                do {
                    print("📝 Attempting sign up for new Apple user")
                    // Generate a secure random password for Apple users
                    let randomPassword = UUID().uuidString + UUID().uuidString
                    // Store password for future sign-ins
                    UserDefaults.standard.set(randomPassword, forKey: "apple_user_password_\(appleUserID)")
                    
                    let user = try await supabaseService.signUp(
                        email: finalEmail,
                        password: randomPassword,
                        username: username.isEmpty ? "Apple User" : username
                    )
                    
                    await MainActor.run {
                        self.isAuthenticated = true
                        self.currentUser = user
                        UserDefaults.standard.set(true, forKey: "isAuthenticated")
                        UserDefaults.standard.set(user.id, forKey: "current_user_id")
                        HapticManager.shared.success()
                        print("✅ Apple Sign In successful (new user)")
                    }
                } catch {
                    print("❌ Apple Sign In error: \(error.localizedDescription)")
                    await MainActor.run {
                        HapticManager.shared.error()
                        // For testing: create local user if Supabase fails
                        // This allows testing without proper OAuth setup
                        let appleUser = User(
                            id: appleUserID,
                            email: finalEmail,
                            username: username.isEmpty ? "Apple User" : username,
                            avatarUrl: nil,
                            bio: nil,
                            location: nil,
                            points: 0,
                            level: .bronze,
                            createdAt: Date()
                        )
                        self.isAuthenticated = true
                        self.currentUser = appleUser
                        UserDefaults.standard.set(true, forKey: "isAuthenticated")
                        print("⚠️ Using local user (Supabase sign up failed)")
                    }
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let errorMsg = error.localizedDescription
        print("❌ Sign in with Apple failed: \(errorMsg)")
        
        // Check for specific error types
        if let authError = error as? ASAuthorizationError {
            switch authError.code {
            case .canceled:
                print("⚠️ User canceled Apple Sign In")
            case .failed:
                print("❌ Apple Sign In failed")
            case .invalidResponse:
                print("❌ Invalid response from Apple")
            case .notHandled:
                print("❌ Apple Sign In not handled")
            case .unknown:
                print("❌ Unknown Apple Sign In error")
            @unknown default:
                print("❌ Unknown Apple Sign In error code")
            }
        }
        
        HapticManager.shared.error()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}
