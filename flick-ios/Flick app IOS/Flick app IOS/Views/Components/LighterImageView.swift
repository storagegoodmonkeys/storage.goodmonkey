//
//  LighterImageView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct LighterImageView: View {
    let lighter: Lighter
    let index: Int
    
    var body: some View {
        ZStack {
            // Subtle background
            getBackgroundGradient()
            
            // Main Clipper lighter body - realistic proportions
            VStack(spacing: 0) {
                // Flip-top cap
                ClipperCap(index: index)
                
                // Main body
                ClipperBody(index: index)
            }
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        }
        .frame(width: 120, height: 160)
        .clipped()
    }
    
    @ViewBuilder
    private func getBackgroundGradient() -> some View {
        RadialGradient(
            colors: [
                Color.white.opacity(0.3),
                Color.white.opacity(0.05)
            ],
            center: .center,
            startRadius: 30,
            endRadius: 80
        )
    }
}

// MARK: - Clipper Cap (Top section with spark wheel)
struct ClipperCap: View {
    let index: Int
    
    var body: some View {
        ZStack {
            // Cap background - metallic silver/chrome
            RoundedRectangle(cornerRadius: 6)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.85, green: 0.85, blue: 0.9),
                            Color(red: 0.7, green: 0.7, blue: 0.75),
                            Color(red: 0.85, green: 0.85, blue: 0.9)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 25)
            
            // Spark wheel - realistic with grooves
            ZStack {
                // Wheel base
                Circle()
                    .fill(Color(red: 0.6, green: 0.6, blue: 0.65))
                    .frame(width: 22, height: 22)
                
                // Wheel grooves
                ForEach(0..<8) { i in
                    Rectangle()
                        .fill(Color(red: 0.5, green: 0.5, blue: 0.55))
                        .frame(width: 1, height: 22)
                        .rotationEffect(.degrees(Double(i) * 45))
                }
                
                // Wheel center
                Circle()
                    .fill(Color(red: 0.7, green: 0.7, blue: 0.75))
                    .frame(width: 8, height: 8)
            }
            .offset(y: -2)
            
            // Metallic shine
            RoundedRectangle(cornerRadius: 6)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.4),
                            Color.clear
                        ],
                        startPoint: .topLeading,
                        endPoint: .center
                    )
                )
                .frame(width: 50, height: 25)
        }
    }
}

// MARK: - Clipper Body (Main colored section)
struct ClipperBody: View {
    let index: Int
    
    var body: some View {
        ZStack {
            // Main body with Clipper-style design
            RoundedRectangle(cornerRadius: 8)
                .fill(getBodyColor())
                .frame(width: 50, height: 100)
            
            // Design pattern overlay
            getBodyPattern()
                .frame(width: 50, height: 100)
            
            // Brand text area (where "Clipper" would be)
            VStack(spacing: 0) {
                Spacer()
                
                // "FLICK" text simulation
                Text("FLICK")
                    .font(.system(size: 6, weight: .bold, design: .rounded))
                    .foregroundColor(getTextColor())
                    .opacity(0.7)
                    .padding(.bottom, 8)
            }
            .frame(width: 50, height: 100)
            
            // Bottom metallic accent
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.75, green: 0.75, blue: 0.8),
                                Color(red: 0.65, green: 0.65, blue: 0.7)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 50, height: 12)
            }
            .frame(width: 50, height: 100)
            
            // 3D shading
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.2),
                            Color.clear,
                            Color.black.opacity(0.1)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 100)
        }
    }
    
    private func getBodyColor() -> Color {
        let colors: [Color] = [
            // Ocean Blue
            Color(red: 0.2, green: 0.5, blue: 0.85),
            // Purple Dreams
            Color(red: 0.7, green: 0.3, blue: 0.8),
            // Orange Graffiti
            Color(red: 0.95, green: 0.5, blue: 0.2),
            // Pink Fantasy
            Color(red: 0.95, green: 0.4, blue: 0.7),
            // Classic Blue
            Color(red: 0.2, green: 0.6, blue: 0.95),
            // Vintage Red
            Color(red: 0.9, green: 0.2, blue: 0.25)
        ]
        return colors[index % colors.count]
    }
    
    @ViewBuilder
    private func getBodyPattern() -> some View {
        switch index % 6 {
        case 0: // Ocean waves
            OceanWavePattern()
                .fill(Color.white.opacity(0.15))
        case 1: // Diagonal stripes
            DiagonalStripePattern()
                .fill(Color.white.opacity(0.2))
        case 2: // Horizontal bands
            HorizontalBandPattern()
                .fill(Color.white.opacity(0.15))
        case 3: // Swirl pattern
            SwirlPattern()
                .fill(Color.white.opacity(0.2))
        case 4: // Geometric dots
            DotPattern()
                .fill(Color.white.opacity(0.2))
        default: // Gradient fade
            RadialGradient(
                colors: [
                    Color.white.opacity(0.3),
                    Color.clear
                ],
                center: .center,
                startRadius: 10,
                endRadius: 30
            )
        }
    }
    
    private func getTextColor() -> Color {
        index % 2 == 0 ? Color.white : Color.black.opacity(0.6)
    }
}

// MARK: - Pattern Shapes
struct OceanWavePattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight: CGFloat = 8
        let waveCount = 3
        
        for i in 0..<waveCount {
            let y = rect.height * CGFloat(i + 1) / CGFloat(waveCount + 1)
            
            path.move(to: CGPoint(x: 0, y: y))
            for x in stride(from: 0, through: rect.width, by: 4) {
                let offset = sin((x / rect.width) * .pi * 4) * waveHeight
                path.addLine(to: CGPoint(x: x, y: y + offset))
            }
        }
        
        return path
    }
}

struct DiagonalStripePattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let stripeWidth: CGFloat = 4
        let spacing: CGFloat = 8
        
        for i in stride(from: -rect.height, through: rect.width + rect.height, by: spacing) {
            path.move(to: CGPoint(x: i, y: 0))
            path.addLine(to: CGPoint(x: i + rect.height, y: rect.height))
            path.addLine(to: CGPoint(x: i + rect.height + stripeWidth, y: rect.height))
            path.addLine(to: CGPoint(x: i + stripeWidth, y: 0))
            path.closeSubpath()
        }
        
        return path
    }
}

struct HorizontalBandPattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let bandHeight: CGFloat = 8
        let spacing: CGFloat = 12
        
        for y in stride(from: 0, through: rect.height, by: spacing) {
            path.addRect(CGRect(x: 0, y: y, width: rect.width, height: bandHeight))
        }
        
        return path
    }
}

struct SwirlPattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius: CGFloat = 15
        let turns: CGFloat = 2.5
        
        path.move(to: center)
        
        for angle in stride(from: 0, through: .pi * 2 * turns, by: 0.1) {
            let currentRadius = radius + (angle / (.pi * 2)) * 5
            let x = center.x + cos(angle) * currentRadius
            let y = center.y + sin(angle) * currentRadius
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return path.strokedPath(StrokeStyle(lineWidth: 2, lineCap: .round))
    }
}

struct DotPattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let dotSize: CGFloat = 3
        let spacing: CGFloat = 8
        
        for x in stride(from: spacing, to: rect.width, by: spacing) {
            for y in stride(from: spacing, to: rect.height, by: spacing) {
                let dotRect = CGRect(
                    x: x - dotSize/2,
                    y: y - dotSize/2,
                    width: dotSize,
                    height: dotSize
                )
                path.addEllipse(in: dotRect)
            }
        }
        
        return path
    }
}

#Preview {
    HStack(spacing: 20) {
        ForEach(0..<6) { index in
            LighterImageView(
                lighter: Lighter(
                    id: "preview-\(index)",
                    qrCode: "FLICK-PREV\(index)",
                    ownerId: "user-1",
                    brand: "Preview",
                    color: nil,
                    photoUrl: nil,
                    status: .owned,
                    registeredAt: Date(),
                    currentLocation: nil
                ),
                index: index
            )
        }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
