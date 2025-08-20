//
//  RootNavigationView.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI

struct RootNavigationView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        switch router.currentRoute {
        case .login:
            LoginView()
        case .register:
            RegisterView()
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
