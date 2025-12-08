//
//  MockData.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import Foundation

class MockData: ObservableObject {
    static let shared = MockData()
    private let supabaseService = SupabaseService.shared
    
    // Use UUIDs for mock data to match Supabase format
    static let mockUserId = "00000000-0000-0000-0000-000000000001"
    
    // Store lighter IDs as static constants for use in other property initializers
    private static let lighterId1 = UUID().uuidString
    private static let lighterId2 = UUID().uuidString
    private static let lighterId3 = UUID().uuidString
    private static let lighterId4 = UUID().uuidString
    private static let lighterId5 = UUID().uuidString
    private static let lighterId6 = UUID().uuidString
    private static let lighterId7 = UUID().uuidString
    private static let lighterId8 = UUID().uuidString
    private static let lighterId9 = UUID().uuidString
    
    @Published var lighters: [Lighter] = [
        Lighter(
            id: lighterId1,
            qrCode: "FLICK-ABC123",
            ownerId: mockUserId,
            brand: "Clipper Ocean",
            color: "Multi-color",
            photoUrl: nil,
            status: .owned,
            registeredAt: Date(),
            currentLocation: Location(latitude: 40.7128, longitude: -74.0060)
        ),
        Lighter(
            id: lighterId2,
            qrCode: "FLICK-XYZ789",
            ownerId: mockUserId,
            brand: "Clipper Dreams",
            color: "Purple",
            photoUrl: nil,
            status: .owned,
            registeredAt: Date(),
            currentLocation: nil
        ),
        Lighter(
            id: lighterId3,
            qrCode: "FLICK-DEF456",
            ownerId: mockUserId,
            brand: "Clipper Graffiti",
            color: "Colorful",
            photoUrl: nil,
            status: .trading,
            registeredAt: Date(),
            currentLocation: nil
        ),
        Lighter(
            id: lighterId4,
            qrCode: "FLICK-GHI012",
            ownerId: mockUserId,
            brand: "Clipper Fantasy",
            color: "Pink",
            photoUrl: nil,
            status: .owned,
            registeredAt: Date(),
            currentLocation: nil
        ),
        Lighter(
            id: lighterId5,
            qrCode: "FLICK-JKL345",
            ownerId: mockUserId,
            brand: "Clipper Classic",
            color: "Blue",
            photoUrl: nil,
            status: .owned,
            registeredAt: Date(),
            currentLocation: nil
        ),
        Lighter(
            id: lighterId6,
            qrCode: "FLICK-MNO678",
            ownerId: mockUserId,
            brand: "Clipper Vintage",
            color: "Red",
            photoUrl: nil,
            status: .owned,
            registeredAt: Date(),
            currentLocation: nil
        ),
        Lighter(
            id: lighterId7,
            qrCode: "FLICK-PQR901",
            ownerId: mockUserId,
            brand: "Clipper Neon",
            color: "Neon Green",
            photoUrl: nil,
            status: .owned,
            registeredAt: Date(),
            currentLocation: nil
        ),
        Lighter(
            id: lighterId8,
            qrCode: "FLICK-STU234",
            ownerId: mockUserId,
            brand: "Clipper Retro",
            color: "Orange",
            photoUrl: nil,
            status: .owned,
            registeredAt: Date(),
            currentLocation: nil
        ),
        Lighter(
            id: lighterId9,
            qrCode: "FLICK-VWX567",
            ownerId: mockUserId,
            brand: "Clipper Metal",
            color: "Silver",
            photoUrl: nil,
            status: .owned,
            registeredAt: Date(),
            currentLocation: nil
        )
    ]
    
    let currentUser = User(
        id: mockUserId,
        email: "demo@flick.app",
        username: "DemoUser",
        avatarUrl: nil,
        bio: "Lighter collector since 2024",
        location: "New York, NY",
        points: 1250,
        level: .silver,
        createdAt: Date()
    )
    
    // Lighter images array for cycling
    let lighterImageNames = ["Lighter1", "Lighter2", "Lighter3", "Lighter4"]
    
    let marketplaceLighters: [Lighter] = [
        Lighter(
            id: UUID().uuidString,
            qrCode: "FLICK-MKT001",
            ownerId: "00000000-0000-0000-0000-000000000002",
            brand: "Zippo Vintage",
            color: "Gold",
            photoUrl: nil,
            status: .trading,
            registeredAt: Date(),
            currentLocation: nil
        ),
        Lighter(
            id: UUID().uuidString,
            qrCode: "FLICK-MKT002",
            ownerId: "00000000-0000-0000-0000-000000000003",
            brand: "Limited Edition",
            color: "Black & Gold",
            photoUrl: nil,
            status: .trading,
            registeredAt: Date(),
            currentLocation: nil
        )
    ]
    
    let achievements: [Achievement] = [
        Achievement(
            id: UUID().uuidString,
            userId: mockUserId,
            badgeType: "First Scan",
            title: "First Light",
            description: "Scanned your first lighter",
            icon: "flame.fill",
            earnedAt: Date()
        ),
        Achievement(
            id: UUID().uuidString,
            userId: mockUserId,
            badgeType: "Collector",
            title: "Collector",
            description: "Registered 3 lighters",
            icon: "star.fill",
            earnedAt: Date()
        ),
        Achievement(
            id: UUID().uuidString,
            userId: mockUserId,
            badgeType: "Trader",
            title: "Trader",
            description: "Completed your first trade",
            icon: "handshake.fill",
            earnedAt: Date()
        )
    ]
    
    let lostFound: [LostFound] = [
        LostFound(
            id: UUID().uuidString,
            lighterId: lighterId6, // Use static lighter ID (index 5 = lighterId6)
            reporterId: "00000000-0000-0000-0000-000000000004",
            status: .lost,
            description: "Lost at Central Park, NYC",
            lastLocation: Location(latitude: 40.7829, longitude: -73.9654),
            reportedAt: Date()
        )
    ]
    
    // Helper function to get image name for a lighter
    func getImageName(for lighter: Lighter) -> String {
        if let index = lighters.firstIndex(where: { $0.id == lighter.id }) {
            return lighterImageNames[index % lighterImageNames.count]
        }
        if let index = marketplaceLighters.firstIndex(where: { $0.id == lighter.id }) {
            return lighterImageNames[(lighters.count + index) % lighterImageNames.count]
        }
        return lighterImageNames[0]
    }
    
    // Helper function to get image name by index
    func getImageName(at index: Int) -> String {
        return lighterImageNames[index % lighterImageNames.count]
    }
    
    // Function to add a new lighter - syncs with Supabase
    func addLighter(qrCode: String, brand: String? = nil) {
        let newLighter = Lighter(
            id: UUID().uuidString,
            qrCode: qrCode,
            ownerId: currentUser.id,
            brand: brand ?? "New Lighter",
            color: nil,
            photoUrl: nil,
            status: .owned,
            registeredAt: Date(),
            currentLocation: nil
        )
        lighters.append(newLighter)
        
        // Save to Supabase
        Task {
            do {
                try await SupabaseService.shared.addLighter(newLighter)
                print("✅ Lighter saved to Supabase: \(qrCode)")
            } catch {
                print("❌ Failed to save lighter to Supabase: \(error.localizedDescription)")
            }
        }
    }
    
    // Check if QR code already exists
    func qrCodeExists(_ qrCode: String) -> Bool {
        return lighters.contains { $0.qrCode == qrCode }
    }
    
    private init() {
        // Load lighters from Supabase on initialization
        loadLightersFromSupabase()
    }
    
    // Load lighters from Supabase
    func loadLightersFromSupabase() {
        Task {
            do {
                // Only load if authenticated
                if let userId = UserDefaults.standard.string(forKey: "current_user_id") {
                    let supabaseLighters = try await supabaseService.getLighters(userId: userId)
                    await MainActor.run {
                        // Merge with local lighters, avoiding duplicates
                        let existingIds = Set(self.lighters.map { $0.id })
                        let newLighters = supabaseLighters.filter { !existingIds.contains($0.id) }
                        self.lighters.append(contentsOf: newLighters)
                        print("✅ Loaded \(supabaseLighters.count) lighters from Supabase")
                    }
                }
            } catch {
                print("⚠️ Failed to load lighters from Supabase (using local data): \(error.localizedDescription)")
            }
        }
    }
    
    // Update lighter in both local array and Supabase
    func updateLighter(_ lighter: Lighter) {
        if let index = lighters.firstIndex(where: { $0.id == lighter.id }) {
            lighters[index] = lighter
            
            // Update in Supabase
            Task {
                do {
                    try await supabaseService.updateLighter(lighter)
                    print("✅ Lighter updated in Supabase: \(lighter.qrCode)")
                } catch {
                    print("❌ Failed to update lighter in Supabase: \(error.localizedDescription)")
                }
            }
        }
    }
}
