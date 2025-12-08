//
//  SignInWithAppleButton.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            HapticManager.shared.impact(.medium)
            action()
        }) {
            HStack(spacing: AppTheme.Spacing.sm) {
                Image(systemName: "applelogo")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("Continue with Apple")
                    .font(AppTheme.Typography.subheadline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: AppTheme.Button.height)
            .background(Color.black)
            .cornerRadius(AppTheme.Radius.button)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Native Sign in with Apple (for actual implementation)
struct NativeSignInWithAppleButton: UIViewRepresentable {
    let onCompletion: (Bool) -> Void
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        button.addTarget(context.coordinator, action: #selector(Coordinator.handleAuthorization), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onCompletion: onCompletion)
    }
    
    class Coordinator: NSObject {
        let onCompletion: (Bool) -> Void
        
        init(onCompletion: @escaping (Bool) -> Void) {
            self.onCompletion = onCompletion
        }
        
        @objc func handleAuthorization() {
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self
            controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
            controller.performRequests()
        }
    }
}

extension NativeSignInWithAppleButton.Coordinator: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        onCompletion(true)
        HapticManager.shared.success()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        onCompletion(false)
        HapticManager.shared.error()
    }
}

extension NativeSignInWithAppleButton.Coordinator: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}

