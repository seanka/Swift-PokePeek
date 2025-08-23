//
//  AppRoute.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

enum AppTabs {
    case homeTab
    case profileTab
}

enum RootView: Hashable {
    case main
    case login
    case onboarding
}

enum ChildView: Hashable {
    case login
    case search
    case detail(pokemonName: String)
    case register(email: String)
    case passwordReset(email: String)
}
