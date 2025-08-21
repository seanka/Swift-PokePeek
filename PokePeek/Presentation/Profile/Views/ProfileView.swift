//
//  ProfileView.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack() {
            Text("Profile")
            
            Text(viewModel.userData?.name ?? "")
            Text(viewModel.userData?.email ?? "")
            Text("\(String(describing: viewModel.userData?.createdAt))")
            
            Button("Logout") {
                viewModel.logoutUser()
            }
        }
        .onAppear {
            viewModel.fetchUserData()
            
            viewModel.userShouldLogin.subscribe(onNext: { shouldLogin in
                guard shouldLogin else { return }
                
                if shouldLogin {
                    router.push(to: .login)
                }
            }).disposed(by: viewModel.disposeBag)
        }
    }
}

#Preview {
    ProfileView(viewModel: DependencyContainer.shared.provideProfileViewModel())
}
