//
//  PokePeekApp.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI

@main
struct PokePeekApp: App {
    @StateObject private var router: AppRouter
    
    init() {
        let container = DependencyContainer.shared
        _router = StateObject(wrappedValue: container.provideAppRouter())
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = urls[0]
        print(documentsDirectory)
    }
    
    var body: some Scene {
        WindowGroup {
            RootNavigationView()
                .environmentObject(router)
        }
    }
}
