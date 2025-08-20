//
//  RegistrationView.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
            
            Button("Already have an account? Login") {
                router.navigate(to: .login)
            }
        }
    }
}

#Preview {
    RegisterView()
}
