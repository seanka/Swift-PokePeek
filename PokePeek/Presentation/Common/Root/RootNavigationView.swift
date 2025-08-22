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
        switch router.root {
            
        case .login:
            LoginView(viewModel: dependencyContainer.provideAuthViewModel())
                .environmentObject(router)
            
        case .main:
            NavigationStack(path: $router.path) {
                MainTabView()
                    .environmentObject(router)
                    .navigationDestination(for: ChildView.self) { screen in
                        switch screen {
                        case .detail(let name):
                            DetailView(
                                viewModel: DependencyContainer.shared.provideDetailViewModel(),
                                pokemonName: name
                            )
                            .environmentObject(router)
                            
                        case .login:
                            LoginView(viewModel: dependencyContainer.provideAuthViewModel())
                                .environmentObject(router)
                            
                        case .register(let email):
                            RegistrationView(viewModel: dependencyContainer.provideAuthViewModel(), preffiledEmail: email)
                                .environmentObject(router)
                            
                        case .search:
                            SearchView(viewModel: dependencyContainer.provideSearchViewModel())
                                .environmentObject(router)
                        }
                    }
            }
        }
    }
}

#Preview {
    RootNavigationView()
}
