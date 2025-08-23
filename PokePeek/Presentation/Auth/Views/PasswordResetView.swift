//
//  PasswordResetView.swift
//  PokePeek
//
//  Created by Sean Anderson on 22/08/25.
//

import SwiftUI

struct PasswordResetView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject var viewModel: PasswordResetViewModel
    
    public var preffiledEmail: String?
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                
                Text("Don't Worry,")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                
                Text("We've got you covered! Reset your password below.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.trailing, 40)
                
                // Form
                TextField("Email", text: .constant(preffiledEmail!))
                    .textFieldStyle(.plain)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .onTapGesture {
                        router.pop()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.gray.opacity(0.3))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.top, 12)
                
                SecureField("New Password", text: $viewModel.password)
                    .textFieldStyle(.plain)
                    .background(Color.clear)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                
                // Continue Button
                HStack {
                    Spacer()
                    ContinueAuthButton {
                        guard let email = preffiledEmail else { return }
                        
                        viewModel.resetPassword(email: email)
                    }
                }
                .padding(.top, 20)
            }
            .onAppear {
                viewModel.actionSucceeded.subscribe(onNext: { succeeded in
                    guard let succeed = succeeded, succeed else { return }
                    
                    router.pop()
                }).disposed(by: viewModel.disposeBag)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            
            if viewModel.loading {
                ShimmerView(isPresented: $viewModel.loading)
                    .background(Color.white)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    PasswordResetView(
        viewModel: DependencyContainer.shared.providePasswordResetViewModel(),
        preffiledEmail: ""
    )
}
