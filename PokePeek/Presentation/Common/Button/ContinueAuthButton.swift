//
//  ContinueAuthButton.swift
//  PokePeek
//
//  Created by Sean Anderson on 22/08/25.
//

import SwiftUI

struct ContinueAuthButton: View {
    public let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("→")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.red, Color.white]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(Circle())
                .shadow(radius: 6)
        }
    }
}

#Preview {
    ContinueAuthButton(action: {})
}
