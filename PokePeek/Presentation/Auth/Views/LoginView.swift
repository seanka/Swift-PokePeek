//
//  LoginView.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            
            // Icon
            Image("ic_pokeball")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .shadow(radius: 6)
            
            Text("Welcome\nto PokéPeek!")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            Text("Before continue, please login / register into your account")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.trailing, 40)
            
            // Form
            VStack(alignment: .leading, spacing: 8) {
                // Email field
                TextField("Email", text: $viewModel.user.email)
                    .textFieldStyle(.plain)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .onTapGesture {
                        viewModel.resetState()
                    }
                    .background(	
                        RoundedRectangle(cornerRadius: 6)
                            .fill(viewModel.emailError
                                   ? Color.red.opacity(0.3)
                                   : viewModel.userExist == true
                                        ? Color.gray.opacity(0.3)
                                        : Color.clear)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(viewModel.emailError
                                        ? Color.red.opacity(0.5)
                                        : Color.gray.opacity(0.5),
                                    lineWidth: 1)
                    )
                    .onChange(of: viewModel.user.email) { _ in
                        viewModel.validateEmail()
                    }
                
                // Email not valid error
                if viewModel.emailError {
                    Text("Please enter a valid email address.")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color.red.opacity(0.5))
                }

                // Password field
                if viewModel.userExist == true {
                    SecureField("Password", text: $viewModel.user.password)
                        .textFieldStyle(.plain)
                        .autocapitalization(.none)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(viewModel.authError ? Color.red.opacity(0.2) : Color.clear)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(viewModel.authError
                                            ? Color.red.opacity(0.5)
                                            : Color.gray.opacity(0.5),
                                        lineWidth: 1)
                        )
                        .onChange(of: viewModel.user.password) { _ in
                            viewModel.authError = false
                        }
                    
                    // Login error
                    if viewModel.authError {
                        Text("⚠️ Invalid password")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Color.red.opacity(0.5))
                    }
                }
            }
            
            // Continue Button
            HStack {
                resetPasswordButton
                Spacer()
                ContinueAuthButton {
                    // Return when there are errors
                    guard !viewModel.authError, !viewModel.emailError else { return }
                    
                    // Return when user not exist (Register flow)
                    guard let userExist = viewModel.userExist else {
                        viewModel.checkUserExist()
                        return
                    }
                    
                    if userExist { viewModel.loginUser() }
                }
            }
            .padding(.top, 20)
        }
        .alert("Email not Registered",
               isPresented: Binding(
                    get: { viewModel.userExist == false },
                    set: { if !$0 { viewModel.userExist = nil } }
               ),
               actions: {
                    Button("Cancel", role: .cancel) {
                        viewModel.userExist = nil
                    }
                    Button("Register Now") {
                        router.push(to: .register(email: viewModel.user.email))
                    }
               },
               message: {
                    Text("The email you entered is not registered. Would you like to register now?")
               })
        .onAppear {
            viewModel.actionSucceeded.subscribe(onNext: { succeeded in
                guard succeeded else { return }
                
                router.setRoot(to: .main)
            }).disposed(by: viewModel.disposeBag)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    LoginView(viewModel: DependencyContainer.shared.provideAuthViewModel())
}

extension LoginView {
    private var resetPasswordButton: some View {
        // Only shows when userExist
        if viewModel.userExist == true {
            AnyView(
                Button(action: {
                    router.push(to: .passwordReset(email: viewModel.user.email))
                    viewModel.resetState()
                }) {
                    Text("Forgot your password? Reset")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.blue)
                        .underline()
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            )
        } else { AnyView(EmptyView()) }
    }
}
