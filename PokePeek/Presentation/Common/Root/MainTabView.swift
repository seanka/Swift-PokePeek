//
//  MainTabView.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI
import PagerTabStripView

struct MainTabView: View {
    @EnvironmentObject var router: AppRouter
    @State private var selection: Int = 0

    var body: some View {
        PagerTabStripView(selection: $selection) {
            
            router.tabView(for: .homeTab)
                .id(selection)
                .pagerTabItem(tag: 0) {
                    Text("Home")
                }

            router.tabView(for: .profileTab)
                .id(selection)
                .pagerTabItem(tag: 1) {
                    Text("Profile")
                }
            
        }
        .pagerTabStripViewStyle(.barButton(
            tabItemSpacing: 20,
            tabItemHeight: 44,
            indicatorView: {
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 3)
            }
        ))
    }
}

#Preview {
    MainTabView()
}
