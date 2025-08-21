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
    case login
    case main
}

enum ChildView: Hashable {
    case search
    case detail(pokemonName: String)
    case login
    case register(email: String)
}
