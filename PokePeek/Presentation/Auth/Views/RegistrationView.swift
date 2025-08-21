//
//  RegistrationView.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject var viewModel: AuthViewModel
    
    public var preffiledEmail: String?
    
    @State private var registerSuceeded: Bool = false
    
    init(viewModel: AuthViewModel, preffiledEmail: String?) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
        self.preffiledEmail = preffiledEmail
        if let email = preffiledEmail {
            viewModel.user.email = email
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
            
            TextField("Email", text: $viewModel.user.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disabled(true)
            
            TextField("Name", text: $viewModel.user.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Password", text: $viewModel.user.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Continue") {
                viewModel.registerUser()
            }
        }
        .showBottomMessage(isPresented: $registerSuceeded, message: "✅ Registration Successful")
        .onAppear {
            viewModel.actionSucceeded.subscribe(onNext: { succeeded in
                guard succeeded else { return }
                
                withAnimation { self.registerSuceeded = true }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    router.navigate(to: .login)
                }
            }).disposed(by: viewModel.disposeBag)
        }
    }
}

#Preview {
    RegistrationView(viewModel: DependencyContainer.shared.provideAuthViewModel(), preffiledEmail: "")
}
