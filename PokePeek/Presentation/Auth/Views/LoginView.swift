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
            
            TextField("Email", text: $viewModel.user.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disabled(viewModel.userExist == true)
                .padding(.top, 16)
            
            if viewModel.userExist == true {
                SecureField("Password", text: $viewModel.user.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Continue Button
            HStack {
                Spacer()
                Button(action: {
                    guard let userExist = viewModel.userExist else {
                        viewModel.checkUserExist()
                        return
                    }
                    
                    if userExist { viewModel.loginUser() }
                }) {
                    Text("→")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.red, Color.white]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .clipShape(Circle())
                        .shadow(radius: 6)
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
