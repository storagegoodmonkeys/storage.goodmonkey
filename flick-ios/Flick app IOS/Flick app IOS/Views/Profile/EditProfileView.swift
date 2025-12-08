//
//  EditProfileView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var username = ""
    @State private var bio = ""
    @State private var location = ""
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var profileImage: UIImage? = nil
    @State private var showPhotoPicker = false
    @State private var isSaving = false
    @State private var errorMessage: String? = nil
    @State private var showError = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: AppTheme.Spacing.lg) {
                    // Header
                    HStack {
                        Button(action: {
                            HapticManager.shared.impact(.light)
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18))
                                .foregroundColor(AppTheme.textPrimary)
                        }
                        
                        Spacer()
                        
                        Text("Edit Profile")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        Button(action: {
                            HapticManager.shared.success()
                            Task {
                                await saveProfile()
                            }
                        }) {
                            if isSaving {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: AppTheme.primary))
                                    .frame(width: 20, height: 20)
                            } else {
                                Text("Save")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(AppTheme.primary)
                            }
                        }
                        .disabled(isSaving)
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.vertical, AppTheme.Spacing.md)
                    
                    Divider()
                        .background(AppTheme.border)
                    
                    // Profile Picture
                    VStack(spacing: AppTheme.Spacing.md) {
                        ZStack {
                            Circle()
                                .fill(AppTheme.backgroundTertiary)
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Group {
                                        if let profileImage = profileImage {
                                            Image(uiImage: profileImage)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(Circle())
                                        } else {
                                            Image(systemName: "person.fill")
                                                .font(.system(size: 60))
                                                .foregroundColor(AppTheme.textSecondary)
                                        }
                                    }
                                )
                        }
                        
                        PhotosPicker(
                            selection: $selectedPhoto,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            Text("Change Photo")
                                .font(AppTheme.Typography.subheadline)
                                .foregroundColor(AppTheme.primary)
                        }
                        .onChange(of: selectedPhoto) { _, newItem in
                            Task {
                                if let newItem = newItem {
                                    if let data = try? await newItem.loadTransferable(type: Data.self) {
                                        if let uiImage = UIImage(data: data) {
                                            profileImage = uiImage
                                            HapticManager.shared.success()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, AppTheme.Spacing.lg)
                    
                    // Form Fields
                    VStack(spacing: AppTheme.Spacing.lg) {
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            Text("Username")
                                .font(AppTheme.Typography.caption1)
                                .fontWeight(.semibold)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            TextField("Username", text: $username)
                                .textFieldStyle(ModernTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            Text("Bio")
                                .font(AppTheme.Typography.caption1)
                                .fontWeight(.semibold)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            TextField("Tell us about yourself", text: $bio, axis: .vertical)
                                .textFieldStyle(ModernTextFieldStyle())
                                .lineLimit(3...6)
                        }
                        
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            Text("Location")
                                .font(AppTheme.Typography.caption1)
                                .fontWeight(.semibold)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            TextField("Location", text: $location)
                                .textFieldStyle(ModernTextFieldStyle())
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                    .padding(.top, AppTheme.Spacing.lg)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage ?? "Failed to save profile. Please try again.")
        }
        .onAppear {
            if let currentUser = appState.currentUser ?? authManager.currentUser {
                username = currentUser.username
                bio = currentUser.bio ?? ""
                location = currentUser.location ?? ""
                
                // Load existing profile image if available
                if let avatarUrl = currentUser.avatarUrl, !avatarUrl.isEmpty {
                    loadImage(from: avatarUrl)
                }
            }
        }
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    await MainActor.run {
                        profileImage = image
                    }
                }
            } catch {
                print("Failed to load profile image: \(error)")
            }
        }
    }
    
    private func saveProfile() async {
        guard let currentUser = appState.currentUser ?? authManager.currentUser else {
            await MainActor.run {
                errorMessage = "No user logged in"
                showError = true
            }
            return
        }
        
        await MainActor.run {
            isSaving = true
            errorMessage = nil
        }
        
        do {
            var avatarUrl = currentUser.avatarUrl
            
            // Upload profile image if changed
            if let image = profileImage {
                avatarUrl = try await SupabaseService.shared.uploadProfileImage(image, userId: currentUser.id)
            }
            
            // Create updated user object
            let updatedUser = User(
                id: currentUser.id,
                email: currentUser.email,
                username: username,
                avatarUrl: avatarUrl,
                bio: bio.isEmpty ? nil : bio,
                location: location.isEmpty ? nil : location,
                points: currentUser.points,
                level: currentUser.level,
                createdAt: currentUser.createdAt
            )
            
            // Save to Supabase
            try await SupabaseService.shared.updateUserProfile(updatedUser)
            
            // Update local state
            await MainActor.run {
                appState.currentUser = updatedUser
                authManager.currentUser = updatedUser
                HapticManager.shared.success()
                isSaving = false
                dismiss()
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                showError = true
                isSaving = false
                HapticManager.shared.error()
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
            .environmentObject(AppState())
    }
}

