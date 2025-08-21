//
//  AppRoute.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

enum AppRoute {
    case login
    case register(email: String)
    case main
    case search
    case detail(name: String)
}
