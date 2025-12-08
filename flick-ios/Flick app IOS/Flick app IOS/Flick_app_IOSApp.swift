//
//  Flick_app_IOSApp.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

@main
struct Flick_app_IOSApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var authManager = AuthenticationManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environmentObject(authManager)
                .onAppear {
                    // Check if user is already authenticated via Supabase
                    authManager.checkAuthentication()
                    if authManager.isAuthenticated {
                        appState.signIn(user: authManager.currentUser ?? MockData.shared.currentUser)
                        // Load lighters from Supabase after authentication
                        MockData.shared.loadLightersFromSupabase()
                    }
                }
        }
    }
}

// App State Management
class AppState: ObservableObject {
    @Published var isFirstTime = true
    @Published var isAuthenticated = false
    @Published var currentUser: User? = nil
    
    private let onboardingKey = "hasSeenOnboarding"
    private let authKey = "isAuthenticated"
    
    init() {
        loadState()
    }
    
    func checkAuthentication() {
        // Load saved state
        if UserDefaults.standard.bool(forKey: authKey) {
            isAuthenticated = true
            currentUser = MockData.shared.currentUser
        }
    }
    
    func completeOnboarding() {
        isFirstTime = false
        UserDefaults.standard.set(false, forKey: onboardingKey)
    }
    
    func signIn(user: User) {
        isAuthenticated = true
        currentUser = user
        UserDefaults.standard.set(true, forKey: authKey)
    }
    
    func signOut() {
        isAuthenticated = false
        currentUser = nil
        UserDefaults.standard.set(false, forKey: authKey)
    }
    
    private func loadState() {
        isFirstTime = !UserDefaults.standard.bool(forKey: onboardingKey)
        isAuthenticated = UserDefaults.standard.bool(forKey: authKey)
        if isAuthenticated {
            currentUser = MockData.shared.currentUser
        }
    }
}
