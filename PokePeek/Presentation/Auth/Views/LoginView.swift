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
        VStack(spacing: 20) {
            Text("Login")
            
            TextField("Email", text: $viewModel.user.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disabled(viewModel.userExist == true)
            
            if viewModel.userExist == true {
                SecureField("Password", text: $viewModel.user.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button("Continue") {
                guard let userExist = viewModel.userExist else {
                    viewModel.checkUserExist()
                    return
                }
                
                if userExist { viewModel.loginUser() }
            }
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
                        router.navigate(to: .register(email: viewModel.user.email))
                    }
               },
               message: {
                    Text("The email you entered is not registered. Would you like to register now?")
               })
        .onAppear {
            viewModel.actionSucceeded.subscribe(onNext: { succeeded in
                guard succeeded else { return }
                
                router.navigate(to: .main)
            }).disposed(by: viewModel.disposeBag)
        }
    }
}

#Preview {
    LoginView(viewModel: DependencyContainer.shared.provideAuthViewModel())
}
