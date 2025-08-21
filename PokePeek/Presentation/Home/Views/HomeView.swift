//
//  HomeView.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(viewModel.pokeList.enumerated()), id: \.offset) { index, pokemon in
                    Button(action: {
                        print(pokemon.name)
                    }) {
                        Text(pokemon.name ?? "")
                            .padding(.vertical, 8)
                            .onAppear {
                                viewModel.loadMoreData(currentIndex: index)
                            }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                if viewModel.loading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Pokémon")
            .onAppear {
                if viewModel.pokeList.isEmpty {
                    viewModel.loadInitialData()
                }
            }
        }
    }
}

#Preview {
    HomeView(viewModel: DependencyContainer.shared.provideHomeViewModel())
}
