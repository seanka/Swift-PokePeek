//
//  RootNavigationView.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI

struct RootNavigationView: View {
    @EnvironmentObject var router: AppRouter
    
    private let dependencyContainer = DependencyContainer.shared
    
    var body: some View {
        switch router.currentRoute {
        case .login:
            LoginView(viewModel: dependencyContainer.provideAuthViewModel()).environmentObject(router)
            
        case .register(let email):
            let authVM = dependencyContainer.provideAuthViewModel()
            RegistrationView(viewModel: authVM, preffiledEmail: email).environmentObject(router)
            
        case .main:
            MainTabView()
        case .detail:
            DetailView()
        case .search:
            SearchView()
        }
    }
}

#Preview {
    RootNavigationView()
}
