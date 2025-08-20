//
//  AppRouter.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import Foundation

final class AppRouter: ObservableObject {
    @Published var currentRoute: AppRoute = .main
    
    func navigate(to route: AppRoute) {
        currentRoute = route
    }
}
