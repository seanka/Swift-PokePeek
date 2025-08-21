//
//  AppRouter.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import Foundation
import SwiftUICore

final class AppRouter: ObservableObject {
    @Published var currentRoute: AppRoute = .login
    
    private let userHelper: UserDataHelper
    
    init(userHelper: UserDataHelper) {
        self.userHelper = userHelper
        initialRoute()
    }
    
    private func initialRoute() {
        guard let user = userHelper.fetchLoggedUser() else {
            currentRoute = .login
            return
        }
        
        if userHelper.checkTokenValidity(for: user) {
            currentRoute = .main
        } else {
            currentRoute = .login
            userHelper.invalidateToken(for: user)
        }
    }
    
    func navigate(to route: AppRoute) {
        currentRoute = route
    }
}

extension AppRouter {
    func tabView(for route: AppRoute) -> some View {
        switch route {
        case .homeTab:
            return AnyView(HomeView().environmentObject(self))

        case .profileTab:
            return AnyView(ProfileView().environmentObject(self))

        default:
            return AnyView(EmptyView())
        }
    }
}
