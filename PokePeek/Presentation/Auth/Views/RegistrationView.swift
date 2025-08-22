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
        ZStack {
            Text("Hello")
        }
    }
    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Spacer()
//
//            // Icon
//            Image("ic_pokeball")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 80, height: 80)
//                .shadow(radius: 6)
//            
//            Text("Create Your Account Today")
//                .font(.system(size: 32, weight: .bold, design: .rounded))
//                .foregroundColor(.primary)
//            
//            Text("to access the only Poké dictionary you ever need")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//            
//            // Form
//            VStack(spacing: 16) {
//                TextField("Email", text: $viewModel.user.email)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .keyboardType(.emailAddress)
//                    .autocapitalization(.none)
//                    .disabled(true)
//                
//                TextField("Name", text: $viewModel.user.name)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .keyboardType(.default)
//                    .autocapitalization(.words)
//                
//                SecureField("Password", text: $viewModel.user.password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//            }
//            .padding(.top, 16)
//            
//            // Continue Button
//            HStack {
//                Spacer()
//                Button(action: {
//                    viewModel.registerUser()
//                }) {
//                    Text("→")
//                        .font(.system(size: 20, weight: .bold))
//                        .foregroundColor(.white)
//                        .frame(width: 40, height: 40)
//                        .background(
//                            LinearGradient(gradient: Gradient(colors: [Color.red, Color.white]),
//                                           startPoint: .topLeading,
//                                           endPoint: .bottomTrailing)
//                        )
//                        .clipShape(Circle())
//                        .shadow(radius: 6)
//                }
//            }
//            .padding(.top, 20)
//        }
//        .showBottomMessage(isPresented: $registerSuceeded, message: "✅ Registration Successful")
//        .onAppear {
//            viewModel.actionSucceeded.subscribe(onNext: { succeeded in
//                guard succeeded else { return }
//                
//                withAnimation { self.registerSuceeded = true }
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                    router.pop()
//                }
//            }).disposed(by: viewModel.disposeBag)
//        }
//        .padding(.horizontal, 16)
//        .padding(.vertical, 14)
//    }
}

#Preview {
    RegistrationView(viewModel: DependencyContainer.shared.provideAuthViewModel(), preffiledEmail: "")
}
