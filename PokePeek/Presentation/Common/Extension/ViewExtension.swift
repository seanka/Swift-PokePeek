//
//  ViewExtension.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import Foundation
import SwiftUICore

extension View {
    func showBottomMessage(isPresented: Binding<Bool>, message: String) -> some View {
        self.modifier(Toast(isPresented: isPresented, message: message))
    }
}
