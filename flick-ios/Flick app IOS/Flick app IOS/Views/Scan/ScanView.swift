//
//  ScanView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI
import AVFoundation

struct ScanView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @ObservedObject var mockData = MockData.shared
    @State private var qrCode = ""
    @State private var showingSuccess = false
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            AppTheme.textPrimary.ignoresSafeArea()
            
            VStack {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        HStack(spacing: AppTheme.Spacing.xs) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .font(AppTheme.Typography.subheadline)
                        .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("Scan QR Code")
                        .font(AppTheme.Typography.title3)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Color.clear
                        .frame(width: 60)
                }
                .padding()
                
                Spacer()
                
                // Scanner Area
                ZStack {
                    AppTheme.background.ignoresSafeArea(edges: .bottom)
                        .cornerRadius(AppTheme.Radius.xl, corners: [.topLeft, .topRight])
                    
                    VStack(spacing: AppTheme.Spacing.xl) {
                        // Scanner Frame
                        ZStack {
                            RoundedRectangle(cornerRadius: AppTheme.Radius.lg)
                                .stroke(.white, lineWidth: 3)
                                .frame(width: 280, height: 280)
                            
                            // Corners
                            VStack {
                                HStack {
                                    ScannerCorner(position: .topLeft)
                                    Spacer()
                                    ScannerCorner(position: .topRight)
                                }
                                Spacer()
                                HStack {
                                    ScannerCorner(position: .bottomLeft)
                                    Spacer()
                                    ScannerCorner(position: .bottomRight)
                                }
                            }
                            .frame(width: 280, height: 280)
                        }
                        .padding(.top, AppTheme.Spacing.xxl)
                        
                        Text("Point camera at QR code on your lighter")
                            .font(AppTheme.Typography.subheadline)
                            .foregroundColor(AppTheme.textPrimary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, AppTheme.Spacing.lg)
                        
                        // Manual Entry
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                            Text("Or enter QR code manually")
                                .font(AppTheme.Typography.caption1)
                                .fontWeight(.semibold)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            TextField("Enter QR code (e.g., FLICK-ABC123)", text: $qrCode)
                                .textFieldStyle(ModernTextFieldStyle())
                                .autocapitalization(.allCharacters)
                        }
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        
                        // Buttons
                        VStack(spacing: AppTheme.Spacing.md) {
                            Button(action: {
                                // Open camera for QR scan (placeholder)
                                qrCode = "FLICK-NEW\(Int.random(in: 100...999))"
                            }) {
                                HStack(spacing: AppTheme.Spacing.sm) {
                                    Image(systemName: "camera.fill")
                                    Text("Open Camera")
                                }
                                .font(AppTheme.Typography.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: AppTheme.Button.height)
                                .background(AppTheme.primary)
                                .cornerRadius(AppTheme.Radius.button)
                            }
                            
                            Button(action: {
                                addLighter()
                            }) {
                                Text("Register Lighter")
                                    .font(AppTheme.Typography.headline)
                                    .foregroundColor(AppTheme.textPrimary)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: AppTheme.Button.height)
                                    .background(AppTheme.secondary)
                                    .cornerRadius(AppTheme.Radius.button)
                            }
                            .disabled(qrCode.isEmpty)
                            .opacity(qrCode.isEmpty ? 0.5 : 1.0)
                        }
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        
                        // Info Box
                        HStack(alignment: .top, spacing: AppTheme.Spacing.sm) {
                            Image(systemName: "info.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(AppTheme.info)
                            
                            Text("Scan the QR code on your lighter to register it and start tracking it.")
                                .font(AppTheme.Typography.caption1)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        .padding(AppTheme.Spacing.md)
                        .background(AppTheme.info.opacity(0.1))
                        .cornerRadius(AppTheme.Radius.md)
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        .padding(.bottom, AppTheme.Spacing.xl)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .alert("Success!", isPresented: $showingSuccess) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Lighter registered successfully!")
        }
        .alert("Error", isPresented: $showingError) {
            Button("OK") {
                showingError = false
            }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func addLighter() {
        guard !qrCode.isEmpty else { return }
        
        // Check if QR code already exists
        if mockData.qrCodeExists(qrCode) {
            errorMessage = "This QR code is already registered!"
            showingError = true
            return
        }
        
        // Generate a brand name based on available names
        let brandNames = ["Clipper Ocean", "Clipper Dreams", "Clipper Graffiti", "Clipper Fantasy", "Clipper Classic", "Clipper Vintage"]
        let randomBrand = brandNames.randomElement() ?? "New Clipper"
        
        // Add the lighter (this will sync to Supabase automatically)
        mockData.addLighter(qrCode: qrCode, brand: randomBrand)
        
        // Force UI update by accessing the published property
        // The @ObservedObject in CollectionView will automatically update
        HapticManager.shared.success()
        
        // Show success and dismiss
        showingSuccess = true
    }
}

struct ScannerCorner: View {
    enum Position {
        case topLeft, topRight, bottomLeft, bottomRight
    }
    
    let position: Position
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let size: CGFloat = 30
                let width = geometry.size.width
                let height = geometry.size.height
                
                switch position {
                case .topLeft:
                    path.move(to: CGPoint(x: size, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: size))
                case .topRight:
                    path.move(to: CGPoint(x: width - size, y: 0))
                    path.addLine(to: CGPoint(x: width, y: 0))
                    path.addLine(to: CGPoint(x: width, y: size))
                case .bottomLeft:
                    path.move(to: CGPoint(x: 0, y: height - size))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.addLine(to: CGPoint(x: size, y: height))
                case .bottomRight:
                    path.move(to: CGPoint(x: width, y: height - size))
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: width - size, y: height))
                }
            }
            .stroke(AppTheme.secondary, lineWidth: 3)
        }
        .frame(width: 30, height: 30)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    NavigationStack {
        ScanView()
            .environmentObject(AppState())
    }
}
