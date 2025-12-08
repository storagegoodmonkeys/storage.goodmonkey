//
//  Lighter.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import Foundation

struct Lighter: Identifiable, Codable {
    let id: String
    let qrCode: String
    let ownerId: String
    var brand: String?
    var color: String?
    var photoUrl: String?
    var status: LighterStatus
    let registeredAt: Date
    var currentLocation: Location?
}

enum LighterStatus: String, Codable {
    case owned = "owned"
    case lost = "lost"
    case trading = "trading"
    case found = "found"
    
    var displayName: String {
        rawValue.capitalized
    }
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
}

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let username: String
    var avatarUrl: String?
    var bio: String?
    var location: String?
    var points: Int
    var level: UserLevel
    let createdAt: Date
}

enum UserLevel: String, Codable {
    case bronze = "Bronze"
    case silver = "Silver"
    case gold = "Gold"
    case platinum = "Platinum"
}

struct Achievement: Identifiable, Codable {
    let id: String
    let userId: String
    let badgeType: String
    let title: String
    let description: String
    let icon: String
    let earnedAt: Date
}

struct Trade: Identifiable, Codable {
    let id: String
    let requesterId: String
    let ownerId: String
    let lighterOfferedId: String
    let lighterRequestedId: String
    var status: TradeStatus
    let createdAt: Date
}

enum TradeStatus: String, Codable {
    case pending = "pending"
    case accepted = "accepted"
    case rejected = "rejected"
    case completed = "completed"
}

struct LostFound: Identifiable, Codable {
    let id: String
    let lighterId: String
    let reporterId: String
    var status: LostFoundStatus
    var description: String?
    var lastLocation: Location?
    let reportedAt: Date
}

enum LostFoundStatus: String, Codable {
    case lost = "lost"
    case found = "found"
    case returned = "returned"
}


