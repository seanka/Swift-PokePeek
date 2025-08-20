//
//  LoginView.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
            
            Button("Register") {
                router.navigate(to: .register)
            }
            
            Button("Login") {
                router.navigate(to: .main)
            }
        }
    }
}

#Preview {
    LoginView()
}
