//
//  OnboardingView.swift
//  PokePeek
//
//  Created by Sean Anderson on 23/08/25.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    @EnvironmentObject var router: AppRouter
    @State private var currentPage = 0

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            TabView(selection: $currentPage) {
                VStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.yellow)
                    
                    Text("Welcome to PokePeek")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    
                    Text("Discover and explore Pokémon easily.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .tag(0)

                VStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                    
                    Text("Search & Find")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    
                    Text("Quickly find any Pokémon by name or ID.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .tag(1)

                VStack {
                    Image(systemName: "list.bullet")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                    
                    Text("Track & Learn")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    
                    Text("Get detailed information about every Pokémon.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Button(action: {
                        hasSeenOnboarding = true
                        router.setRoot(to: .main)
                    }) {
                        Text("Get Started")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.top, 40)
                }
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

#Preview {
    OnboardingView()
}
