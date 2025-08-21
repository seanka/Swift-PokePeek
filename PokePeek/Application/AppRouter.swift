//
//  AppRouter.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import Foundation
import SwiftUICore

final class AppRouter: ObservableObject {
    @Published var root: RootView = .login
    @Published var path: [ChildView] = []
    
    var currentChild: ChildView? { path.last }
    
    private let userHelper: UserDataHelper
    
    init(userHelper: UserDataHelper) {
        self.userHelper = userHelper
        initialRoute()
    }
    
    private func initialRoute() {
        guard let user = userHelper.fetchLoggedUser() else {
            setRoot(to: .login)
            return
        }

        if userHelper.checkTokenValidity(for: user) {
            setRoot(to: .main)
        } else {
            setRoot(to: .login)
            userHelper.invalidateToken(for: user)
        }
    }

    // MARK: - Root Navigation
    func setRoot(to root: RootView, clearPath: Bool = true) {
        if clearPath { path.removeAll() }
        self.root = root
    }

    // MARK: - Child Navigation (Push / Pop)
    func push(to screen: ChildView) {
        path.append(screen)
    }

    func pop() {
        _ = path.popLast()
    }

    func popToRootChild() {
        path.removeAll()
    }
}

extension AppRouter {
    func tabView(for route: AppTabs) -> some View {
        switch route {
        case .homeTab:
            let dependencyContainer = DependencyContainer.shared
            return AnyView(HomeView(
                viewModel: dependencyContainer.provideHomeViewModel()
            ).environmentObject(self))

        case .profileTab:
            let dependencyContainer = DependencyContainer.shared
            return AnyView(ProfileView(
                viewModel: dependencyContainer.provideProfileViewModel()).environmentObject(self))
        }
    }
}
