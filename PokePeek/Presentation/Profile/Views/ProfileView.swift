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
        VStack(alignment: .leading, spacing: 10) {
            
            // Introduction
            VStack(alignment: .leading) {
                Text("Hey PokèPal,")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                
                Text(viewModel.userData?.name ?? "")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(Color(UIColor(red: 0.83, green: 0.70, blue: 0.25, alpha: 1.0)))
            }
            
            Text(viewModel.userData?.email ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Button("Logout") {
                viewModel.logoutUser()
            }
        }
        .onAppear {
            viewModel.fetchUserData()
            
            viewModel.userShouldLogin.subscribe(onNext: { shouldLogin in
                guard shouldLogin else { return }
                
                if shouldLogin {
                    router.setRoot(to: .login)
                }
            }).disposed(by: viewModel.disposeBag)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    ProfileView(viewModel: DependencyContainer.shared.provideProfileViewModel())
        .environmentObject(AppRouter(userHelper: UserDataHelper(context: PersistenceController.shared.container.viewContext)))
}
