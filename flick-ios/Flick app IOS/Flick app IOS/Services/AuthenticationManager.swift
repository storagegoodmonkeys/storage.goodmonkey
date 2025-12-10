//
//  AuthenticationManager.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import Foundation
import AuthenticationServices

class AuthenticationManager: NSObject, ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isLoading = false
    
    private let supabaseService = SupabaseService.shared
    
    override init() {
        super.init()
        checkAuthentication()
    }
    
    func checkAuthentication() {
        isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        if isAuthenticated {
            if let userId = UserDefaults.standard.string(forKey: "current_user_id") {
                // Create a placeholder user for testing
                currentUser = User(
                    id: userId,
                    email: "test@test.com",
                    username: "TestUser",
                    avatarUrl: nil,
                    bio: nil,
                    location: nil,
                    points: 100,
                    level: .bronze,
                    createdAt: Date()
                )
            }
        }
    }
    
    // MARK: - Sign In (TESTING MODE - No verification)
    func signIn(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        guard email.contains("@") else {
            completion(false, "Please enter a valid email address")
            return
        }
        
        Task {
            await MainActor.run {
                self.isAuthenticated = true
                self.currentUser = User(
                    id: UUID().uuidString,
                    email: email,
                    username: email.components(separatedBy: "@").first ?? "TestUser",
                    avatarUrl: nil,
                    bio: nil,
                    location: nil,
                    points: 100,
                    level: .bronze,
                    createdAt: Date()
                )
                UserDefaults.standard.set(true, forKey: "isAuthenticated")
                UserDefaults.standard.set(self.currentUser!.id, forKey: "current_user_id")
                HapticManager.shared.success()
                print("✅ TESTING MODE: Signed in as \(email)")
                completion(true, nil)
            }
        }
    }
    
    // MARK: - Sign Up (TESTING MODE - No verification)
    func signUp(email: String, username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        guard email.contains("@") else {
            completion(false, "Please enter a valid email address")
            return
        }
        
        guard !username.isEmpty else {
            completion(false, "Please enter a username")
            return
        }
        
        Task {
            await MainActor.run {
                self.isAuthenticated = true
                self.currentUser = User(
                    id: UUID().uuidString,
                    email: email,
                    username: username,
                    avatarUrl: nil,
                    bio: nil,
                    location: nil,
                    points: 0,
                    level: .bronze,
                    createdAt: Date()
                )
                UserDefaults.standard.set(true, forKey: "isAuthenticated")
                UserDefaults.standard.set(self.currentUser!.id, forKey: "current_user_id")
                HapticManager.shared.success()
                print("✅ TESTING MODE: Signed up as \(email)")
                completion(true, "Account created successfully!")
            }
        }
    }
    
    // MARK: - Sign Out
    func signOut() {
        isAuthenticated = false
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "isAuthenticated")
        UserDefaults.standard.removeObject(forKey: "current_user_id")
        UserDefaults.standard.removeObject(forKey: "supabase_auth_token")
        HapticManager.shared.impact(.medium)
        print("✅ Signed out")
    }
    
    // MARK: - Apple Sign In (TESTING MODE)
    func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
    
    // MARK: - Email Verification (Bypassed for testing)
    func verifyEmailOTP(email: String, code: String, completion: @escaping (Bool, String?) -> Void) {
        // Bypass - any code works
        Task {
            await MainActor.run {
                self.isAuthenticated = true
                self.currentUser = User(
                    id: UUID().uuidString,
                    email: email,
                    username: email.components(separatedBy: "@").first ?? "User",
                    avatarUrl: nil,
                    bio: nil,
                    location: nil,
                    points: 0,
                    level: .bronze,
                    createdAt: Date()
                )
                UserDefaults.standard.set(true, forKey: "isAuthenticated")
                UserDefaults.standard.set(self.currentUser!.id, forKey: "current_user_id")
                HapticManager.shared.success()
                completion(true, nil)
            }
        }
    }
    
    func resendVerificationCode(email: String, completion: @escaping (Bool, String?) -> Void) {
        completion(true, "Code sent (testing mode)")
    }
}

// MARK: - Apple Sign In Delegate
extension AuthenticationManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let email = appleIDCredential.email ?? "apple@user.com"
            let fullName = appleIDCredential.fullName
            let username = fullName?.givenName ?? email.components(separatedBy: "@").first ?? "AppleUser"
            
            Task {
                await MainActor.run {
                    self.isAuthenticated = true
                    self.currentUser = User(
                        id: UUID().uuidString,
                        email: email,
                        username: username,
                        avatarUrl: nil,
                        bio: nil,
                        location: nil,
                        points: 0,
                        level: .bronze,
                        createdAt: Date()
                    )
                    UserDefaults.standard.set(true, forKey: "isAuthenticated")
                    UserDefaults.standard.set(self.currentUser!.id, forKey: "current_user_id")
                    HapticManager.shared.success()
                    print("✅ TESTING MODE: Apple Sign In as \(email)")
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("❌ Apple Sign In Error: \(error.localizedDescription)")
        HapticManager.shared.error()
    }
}
