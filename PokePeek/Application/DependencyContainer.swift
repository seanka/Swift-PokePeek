//
//  DependencyContainer.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import Foundation

final class DependencyContainer {
    static let shared = DependencyContainer()
    
    let userDataHelper: UserDataHelper
    
    private init() {
        self.userDataHelper = UserDataHelper(context: PersistenceController.shared.container.viewContext)
    }
    
    func provideAppRouter() -> AppRouter {
        AppRouter(userHelper: userDataHelper)
    }
    
    func provideAuthViewModel() -> AuthViewModel {
        AuthViewModel(userHelper: userDataHelper)
    }
}
