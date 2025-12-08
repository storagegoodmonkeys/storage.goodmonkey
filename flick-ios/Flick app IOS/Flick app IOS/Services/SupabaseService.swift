//
//  SupabaseService.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import Foundation
import UIKit

class SupabaseService: ObservableObject {
    static let shared = SupabaseService()
    
    // Supabase Configuration
    private let supabaseURL = "https://kjhhwrvduqxprweqxhbo.supabase.co"
    private let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtqaGh3cnZkdXF4cHJ3ZXF4aGJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ2OTAwNjIsImV4cCI6MjA4MDI2NjA2Mn0.GFAmIDb1E_2UnFczUsHv4mTwGCT057CNlSLatsP2g2w"
    
    private var baseURL: String {
        "\(supabaseURL)/rest/v1"
    }
    
    private var authURL: String {
        "\(supabaseURL)/auth/v1"
    }
    
    private var authToken: String? {
        UserDefaults.standard.string(forKey: "supabase_auth_token")
    }
    
    private init() {
        print("✅ SupabaseService initialized")
        print("📍 URL: \(supabaseURL)")
    }
    
    // MARK: - Helper Methods
    
    private func makeRequest<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Data? = nil,
        useAuth: Bool = true
    ) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw SupabaseError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(supabaseKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Only add Prefer header for non-auth requests
        if !endpoint.contains("/auth/") {
            request.setValue("return=representation", forHTTPHeaderField: "Prefer")
        }
        
        if useAuth, let token = authToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
            // Log request body for debugging (without password)
            if let bodyString = String(data: body, encoding: .utf8) {
                let sanitized = bodyString.replacingOccurrences(of: #""password":"[^"]*""#, with: #""password":"***""#, options: .regularExpression)
                print("📤 Request to \(endpoint): \(sanitized)")
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw SupabaseError.invalidResponse
        }
        
        // Log response for debugging
        if let responseString = String(data: data, encoding: .utf8) {
            print("📥 Response (\(httpResponse.statusCode)): \(responseString.prefix(500))")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            // Log the actual error for debugging
            if let errorString = String(data: data, encoding: .utf8) {
                print("❌ Supabase API Error (\(httpResponse.statusCode)): \(errorString)")
            }
            
            if let errorData = try? JSONDecoder().decode(SupabaseErrorResponse.self, from: data) {
                let errorMsg = errorData.message ?? "API error (Code: \(httpResponse.statusCode))"
                print("❌ Error message: \(errorMsg)")
                throw SupabaseError.apiError(errorMsg)
            }
            let errorMsg = "HTTP error \(httpResponse.statusCode): \(String(data: data, encoding: .utf8) ?? "Unknown error")"
            print("❌ \(errorMsg)")
            throw SupabaseError.apiError(errorMsg)
        }
        
        if T.self == EmptyResponse.self {
            return EmptyResponse() as! T
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    }
    
    // MARK: - Authentication
    
    func signUp(email: String, password: String, username: String) async throws -> User {
        let url = "\(authURL)/signup"
        
        // Supabase expects this exact format
        struct SignUpRequest: Codable {
            let email: String
            let password: String
            let data: [String: String]
        }
        
        let request = SignUpRequest(
            email: email,
            password: password,
            data: ["username": username]
        )
        
        let encoder = JSONEncoder()
        let bodyData = try encoder.encode(request)
        
        // For testing: Always try to sign in immediately after signup (no email verification)
        do {
            let response: AuthResponse = try await makeRequest(endpoint: url, method: "POST", body: bodyData, useAuth: false)
            
            // If we got a session, user is immediately signed in (email confirmation disabled)
            if let session = response.normalizedSession {
                UserDefaults.standard.set(session.access_token, forKey: "supabase_auth_token")
                // Wait a bit for the trigger to create the user profile
                try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
                do {
                    return try await getUserProfile(userId: session.user.id)
                } catch {
                    // If profile doesn't exist yet, create basic user
                    return User(
                        id: session.user.id,
                        email: session.user.email ?? email,
                        username: username,
                        avatarUrl: nil,
                        bio: nil,
                        location: nil,
                        points: 0,
                        level: .bronze,
                        createdAt: Date()
                    )
                }
            }
            
            // If no session but we have user, try to sign in immediately (for testing without email verification)
            if let user = response.user {
                print("⚠️ No session after signup, attempting immediate sign in for testing...")
                // Try to sign in with the same credentials
                do {
                    try await Task.sleep(nanoseconds: 1_000_000_000) // Wait 1 second
                    return try await signIn(email: email, password: password)
                } catch {
                    // If sign in fails, still return user object for testing
                    print("⚠️ Sign in after signup failed, returning user object anyway: \(error.localizedDescription)")
                    return User(
                        id: user.id,
                        email: user.email ?? email,
                        username: username,
                        avatarUrl: nil,
                        bio: nil,
                        location: nil,
                        points: 0,
                        level: .bronze,
                        createdAt: Date()
                    )
                }
            }
            
            throw SupabaseError.authenticationFailed
        } catch let error as SupabaseError {
            // Re-throw with better error message
            throw error
        } catch {
            throw SupabaseError.apiError("Sign up failed: \(error.localizedDescription)")
        }
    }
    
    func signIn(email: String, password: String) async throws -> User {
        // Use Supabase auth sign in endpoint (correct format)
        let url = "\(authURL)/token?grant_type=password"
        
        struct SignInRequest: Codable {
            let email: String
            let password: String
        }
        
        let request = SignInRequest(email: email, password: password)
        let encoder = JSONEncoder()
        let bodyData = try encoder.encode(request)
        
        print("🔐 Attempting sign in for: \(email)")
        
        do {
            let response: AuthResponse = try await makeRequest(endpoint: url, method: "POST", body: bodyData, useAuth: false)
            
            // Try to get session (either direct or normalized from token format)
            if let session = response.normalizedSession {
                UserDefaults.standard.set(session.access_token, forKey: "supabase_auth_token")
                print("✅ Sign in successful, token saved for user: \(session.user.id)")
                // Wait a moment for profile to be available
                try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
                do {
                    let user = try await getUserProfile(userId: session.user.id)
                    print("✅ User profile loaded: \(user.username)")
                    return user
                } catch {
                    print("⚠️ Could not load user profile, creating from session")
                    // If profile doesn't exist yet, create a basic user object
                    return User(
                        id: session.user.id,
                        email: session.user.email ?? email,
                        username: email.components(separatedBy: "@").first ?? "User",
                        avatarUrl: nil,
                        bio: nil,
                        location: nil,
                        points: 0,
                        level: .bronze,
                        createdAt: Date()
                    )
                }
            }
            
            // For testing: Try to sign in even if email not confirmed
            // If we have user but no session, try to create a basic session
            if let user = response.user, response.session == nil && response.access_token == nil {
                print("⚠️ No session returned, but user exists. Email confirmation may be required.")
                print("💡 For testing: Email confirmation is disabled - this should not happen.")
                // Still throw error but with clearer message
                throw SupabaseError.apiError("Unable to sign in. Please check your credentials.")
            }
            
            print("❌ No session returned from Supabase")
            throw SupabaseError.authenticationFailed
        } catch let error as SupabaseError {
            print("❌ Sign in error: \(error.localizedDescription)")
            throw error
        } catch {
            print("❌ Sign in error: \(error.localizedDescription)")
            // Check for specific error messages
            let errorString = error.localizedDescription.lowercased()
            if errorString.contains("invalid") || errorString.contains("credentials") {
                throw SupabaseError.apiError("Invalid email or password. Please check your credentials.")
            } else if errorString.contains("email") && errorString.contains("confirm") {
                throw SupabaseError.apiError("Please verify your email before signing in.")
            } else {
                throw SupabaseError.apiError("Sign in failed: \(error.localizedDescription)")
            }
        }
    }
    
    func signOut() async throws {
        let url = "\(authURL)/logout"
        let _: EmptyResponse = try await makeRequest(endpoint: url, method: "POST")
        UserDefaults.standard.removeObject(forKey: "supabase_auth_token")
    }
    
    // MARK: - Email OTP Verification
    
    func sendOTP(email: String, type: String = "signup", data: [String: String]? = nil) async throws {
        let url = "\(authURL)/otp"
        
        struct OTPRequest: Codable {
            let email: String
            let type: String
            let data: [String: String]?
        }
        
        let request = OTPRequest(email: email, type: type, data: data)
        let encoder = JSONEncoder()
        let bodyData = try encoder.encode(request)
        
        print("📧 Sending OTP to: \(email)")
        if let data = data {
            print("📝 With metadata: \(data)")
        }
        
        let _: EmptyResponse = try await makeRequest(endpoint: url, method: "POST", body: bodyData, useAuth: false)
        print("✅ OTP sent successfully")
    }
    
    func verifyOTP(email: String, token: String, type: String = "signup") async throws -> User {
        let url = "\(authURL)/verify"
        
        struct VerifyOTPRequest: Codable {
            let email: String
            let token: String
            let type: String
        }
        
        let request = VerifyOTPRequest(email: email, token: token, type: type)
        let encoder = JSONEncoder()
        let bodyData = try encoder.encode(request)
        
        print("🔐 Verifying OTP for: \(email)")
        
        let response: AuthResponse = try await makeRequest(endpoint: url, method: "POST", body: bodyData, useAuth: false)
        
        if let session = response.session {
            UserDefaults.standard.set(session.access_token, forKey: "supabase_auth_token")
            print("✅ OTP verified, token saved")
            // Wait a moment for profile to be available
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
            return try await getUserProfile(userId: session.user.id)
        }
        
        throw SupabaseError.authenticationFailed
    }
    
    func getCurrentUser() async throws -> User? {
        guard authToken != nil else { return nil }
        
        // Verify token and get user
        let url = "\(authURL)/user"
        do {
            let userResponse: AuthUserResponse = try await makeRequest(endpoint: url, useAuth: true)
            return try await getUserProfile(userId: userResponse.id)
        } catch {
            return nil
        }
    }
    
    // MARK: - User Operations
    
    func getUserProfile(userId: String) async throws -> User {
        let url = "\(baseURL)/users?id=eq.\(userId)&select=*"
        let users: [UserResponse] = try await makeRequest(endpoint: url)
        
        guard let userResponse = users.first else {
            throw SupabaseError.userNotFound
        }
        
        return User(
            id: userResponse.id,
            email: userResponse.email,
            username: userResponse.username,
            avatarUrl: userResponse.avatar_url,
            bio: userResponse.bio,
            location: userResponse.location,
            points: userResponse.points,
            level: UserLevel(rawValue: userResponse.level) ?? .bronze,
            createdAt: ISO8601DateFormatter().date(from: userResponse.created_at) ?? Date()
        )
    }
    
    func updateUserProfile(_ user: User) async throws {
        let url = "\(baseURL)/users?id=eq.\(user.id)"
        var body: [String: Any] = [
            "username": user.username
        ]
        
        if let bio = user.bio {
            body["bio"] = bio
        }
        if let location = user.location {
            body["location"] = location
        }
        if let avatarUrl = user.avatarUrl {
            body["avatar_url"] = avatarUrl
        }
        
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        print("💾 Updating user profile: \(user.id)")
        let _: EmptyResponse = try await makeRequest(endpoint: url, method: "PATCH", body: bodyData)
        print("✅ User profile updated successfully")
    }
    
    func uploadProfileImage(_ image: UIImage, userId: String) async throws -> String {
        // For now, convert image to base64 and store as data URL
        // In production, you'd upload to Supabase Storage
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw SupabaseError.apiError("Failed to convert image to data")
        }
        
        let base64String = imageData.base64EncodedString()
        let dataUrl = "data:image/jpeg;base64,\(base64String)"
        
        // For now, return a placeholder URL - in production, upload to Supabase Storage
        // and return the public URL
        print("📸 Profile image converted (base64, \(base64String.count) chars)")
        
        // TODO: Upload to Supabase Storage bucket
        // For now, we'll store the base64 in the database (not ideal for large images)
        // In production: upload to storage and return public URL
        return dataUrl
    }
    
    // MARK: - Lighter Operations
    
    // Check if we're using mock data (authentication bypassed)
    private func isMockUserId(_ userId: String) -> Bool {
        return userId == "00000000-0000-0000-0000-000000000001" || userId.starts(with: "user-")
    }
    
    func getLighters(userId: String? = nil) async throws -> [Lighter] {
        var url = "\(baseURL)/lighters?select=*"
        if let userId = userId {
            url += "&owner_id=eq.\(userId)"
        }
        
        let response: [LighterResponse] = try await makeRequest(endpoint: url)
        
        return response.map { lighterResponse in
            Lighter(
                id: lighterResponse.id,
                qrCode: lighterResponse.qr_code,
                ownerId: lighterResponse.owner_id,
                brand: lighterResponse.brand,
                color: lighterResponse.color,
                photoUrl: lighterResponse.photo_url,
                status: LighterStatus(rawValue: lighterResponse.status) ?? .owned,
                registeredAt: ISO8601DateFormatter().date(from: lighterResponse.registered_at) ?? Date(),
                currentLocation: lighterResponse.latitude != nil && lighterResponse.longitude != nil
                    ? Location(latitude: lighterResponse.latitude!, longitude: lighterResponse.longitude!)
                    : nil
            )
        }
    }
    
    func addLighter(_ lighter: Lighter) async throws {
        // Skip Supabase if using mock data
        if isMockUserId(lighter.ownerId) {
            print("⚠️ Skipping Supabase save - using mock data (user ID: \(lighter.ownerId))")
            return
        }
        
        let url = "\(baseURL)/lighters"
        var body: [String: Any] = [
            "qr_code": lighter.qrCode,
            "owner_id": lighter.ownerId,
            "status": lighter.status.rawValue
        ]
        
        if let brand = lighter.brand { body["brand"] = brand }
        if let color = lighter.color { body["color"] = color }
        if let photoUrl = lighter.photoUrl { body["photo_url"] = photoUrl }
        if let location = lighter.currentLocation {
            body["latitude"] = location.latitude
            body["longitude"] = location.longitude
        }
        
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        let _: EmptyResponse = try await makeRequest(endpoint: url, method: "POST", body: bodyData)
    }
    
    func updateLighter(_ lighter: Lighter) async throws {
        // Skip Supabase if using mock data
        if isMockUserId(lighter.ownerId) {
            print("⚠️ Skipping Supabase update - using mock data")
            return
        }
        let url = "\(baseURL)/lighters?id=eq.\(lighter.id)"
        var body: [String: Any] = [
            "status": lighter.status.rawValue
        ]
        
        if let brand = lighter.brand { body["brand"] = brand }
        if let color = lighter.color { body["color"] = color }
        if let photoUrl = lighter.photoUrl { body["photo_url"] = photoUrl }
        if let location = lighter.currentLocation {
            body["latitude"] = location.latitude
            body["longitude"] = location.longitude
        }
        
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        let _: EmptyResponse = try await makeRequest(endpoint: url, method: "PATCH", body: bodyData)
    }
    
    func deleteLighter(lighterId: String) async throws {
        // Skip Supabase if using mock data (check ID format)
        if lighterId.starts(with: "lighter-") || lighterId.count < 36 {
            print("⚠️ Skipping Supabase delete - using mock data (lighter ID: \(lighterId))")
            return
        }
        
        let url = "\(baseURL)/lighters?id=eq.\(lighterId)"
        let _: EmptyResponse = try await makeRequest(endpoint: url, method: "DELETE")
    }
    
    func getMarketplaceLighters() async throws -> [Lighter] {
        let url = "\(baseURL)/marketplace_lighters?select=*"
        let response: [LighterResponse] = try await makeRequest(endpoint: url)
        
        return response.map { lighterResponse in
            Lighter(
                id: lighterResponse.id,
                qrCode: lighterResponse.qr_code,
                ownerId: lighterResponse.owner_id,
                brand: lighterResponse.brand,
                color: lighterResponse.color,
                photoUrl: lighterResponse.photo_url,
                status: .trading,
                registeredAt: ISO8601DateFormatter().date(from: lighterResponse.registered_at) ?? Date(),
                currentLocation: lighterResponse.latitude != nil && lighterResponse.longitude != nil
                    ? Location(latitude: lighterResponse.latitude!, longitude: lighterResponse.longitude!)
                    : nil
            )
        }
    }
    
    // MARK: - Trade Operations
    
    func createTrade(trade: Trade) async throws {
        let url = "\(baseURL)/trades"
        let body: [String: Any] = [
            "requester_id": trade.requesterId,
            "owner_id": trade.ownerId,
            "lighter_offered_id": trade.lighterOfferedId,
            "lighter_requested_id": trade.lighterRequestedId,
            "status": trade.status.rawValue
        ]
        
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        let _: EmptyResponse = try await makeRequest(endpoint: url, method: "POST", body: bodyData)
    }
    
    func updateTradeStatus(tradeId: String, status: TradeStatus) async throws {
        let url = "\(baseURL)/trades?id=eq.\(tradeId)"
        let body: [String: String] = ["status": status.rawValue]
        
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        let _: EmptyResponse = try await makeRequest(endpoint: url, method: "PATCH", body: bodyData)
    }
    
    // MARK: - Achievement Operations
    
    func getAchievements(userId: String) async throws -> [Achievement] {
        let url = "\(baseURL)/achievements?user_id=eq.\(userId)&select=*"
        let response: [AchievementResponse] = try await makeRequest(endpoint: url)
        
        return response.map { achievementResponse in
            Achievement(
                id: achievementResponse.id,
                userId: achievementResponse.user_id,
                badgeType: achievementResponse.badge_type,
                title: achievementResponse.title,
                description: achievementResponse.description,
                icon: achievementResponse.icon,
                earnedAt: ISO8601DateFormatter().date(from: achievementResponse.earned_at) ?? Date()
            )
        }
    }
    
    // MARK: - Lost & Found Operations
    
    func reportLostFound(lostFound: LostFound) async throws {
        let url = "\(baseURL)/lost_found"
        var body: [String: Any] = [
            "lighter_id": lostFound.lighterId,
            "reporter_id": lostFound.reporterId,
            "status": lostFound.status.rawValue
        ]
        
        if let description = lostFound.description { body["description"] = description }
        if let location = lostFound.lastLocation {
            body["latitude"] = location.latitude
            body["longitude"] = location.longitude
        }
        
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        let _: EmptyResponse = try await makeRequest(endpoint: url, method: "POST", body: bodyData)
    }
    
    func getLostFound(status: LostFoundStatus? = nil) async throws -> [LostFound] {
        var url = "\(baseURL)/lost_found?select=*"
        if let status = status {
            url += "&status=eq.\(status.rawValue)"
        }
        
        let response: [LostFoundResponse] = try await makeRequest(endpoint: url)
        
        return response.map { lostFoundResponse in
            LostFound(
                id: lostFoundResponse.id,
                lighterId: lostFoundResponse.lighter_id,
                reporterId: lostFoundResponse.reporter_id,
                status: LostFoundStatus(rawValue: lostFoundResponse.status) ?? .lost,
                description: lostFoundResponse.description,
                lastLocation: lostFoundResponse.latitude != nil && lostFoundResponse.longitude != nil
                    ? Location(latitude: lostFoundResponse.latitude!, longitude: lostFoundResponse.longitude!)
                    : nil,
                reportedAt: ISO8601DateFormatter().date(from: lostFoundResponse.reported_at) ?? Date()
            )
        }
    }
}

// MARK: - Response Models

private struct UserResponse: Codable {
    let id: String
    let email: String
    let username: String
    let avatar_url: String?
    let bio: String?
    let location: String?
    let points: Int
    let level: String
    let created_at: String
}

private struct LighterResponse: Codable {
    let id: String
    let qr_code: String
    let owner_id: String
    let brand: String?
    let color: String?
    let photo_url: String?
    let status: String
    let registered_at: String
    let latitude: Double?
    let longitude: Double?
}

private struct AchievementResponse: Codable {
    let id: String
    let user_id: String
    let badge_type: String
    let title: String
    let description: String
    let icon: String
    let earned_at: String
}

private struct LostFoundResponse: Codable {
    let id: String
    let lighter_id: String
    let reporter_id: String
    let status: String
    let description: String?
    let latitude: Double?
    let longitude: Double?
    let reported_at: String
}

private struct AuthResponse: Codable {
    let session: AuthSession?
    let user: AuthUser?
    let message: String?
    // Handle OAuth2 token response format (direct access_token)
    let access_token: String?
    let token_type: String?
    let expires_in: Int?
    
    // Convert direct token format to session format
    var normalizedSession: AuthSession? {
        if let session = session {
            return session
        }
        // If we have direct token format, create a session
        if let access_token = access_token,
           let expires_in = expires_in,
           let user = user {
            return AuthSession(
                access_token: access_token,
                token_type: token_type ?? "bearer",
                expires_in: expires_in,
                user: user
            )
        }
        return nil
    }
}

private struct AuthSession: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    let user: AuthUser
}

private struct AuthUser: Codable {
    let id: String
    let email: String?
    let phone: String?
}

private struct AuthUserResponse: Codable {
    let id: String
    let email: String?
}

private struct EmptyResponse: Codable {}

private struct SupabaseErrorResponse: Codable {
    let message: String?
    let code: String?
    let details: String?
}

// MARK: - Errors

enum SupabaseError: LocalizedError {
    case invalidURL
    case invalidResponse
    case authenticationFailed
    case userNotFound
    case networkError(Error)
    case apiError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .authenticationFailed:
            return "Authentication failed"
        case .userNotFound:
            return "User not found"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .apiError(let message):
            return "API error: \(message)"
        }
    }
}
