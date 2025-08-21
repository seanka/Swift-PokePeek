//
//  Toast.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import Foundation
import SwiftUICore

struct Toast: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                VStack {
                    Spacer()
                    
                    Text(message)
                        .padding()
                        .background(Color.green.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
                .padding()
            }
        }
    }
}
