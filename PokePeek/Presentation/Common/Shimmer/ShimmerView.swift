//
//  ShimmerView.swift
//  PokePeek
//
//  Created by Sean Anderson on 22/08/25.
//

import SwiftUI
import MBProgressHUD

struct ShimmerView: UIViewRepresentable {
    @Binding var isPresented: Bool
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if isPresented {
            let hud = MBProgressHUD.showAdded(to: uiView, animated: true)
            hud.label.text = "Loading..."
            hud.isUserInteractionEnabled = false
        } else {
            MBProgressHUD.hide(for: uiView, animated: true)
        }
    }
}

#Preview {
    ShimmerView(isPresented: .constant(true))
}
