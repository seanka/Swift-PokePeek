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
            ZStack {
                List {
                    ForEach(Array(viewModel.pokeList.enumerated()), id: \.offset) { index, pokemon in
                        Button(action: {
                            router.push(to: .detail(pokemonName: pokemon.name ?? ""))
                        }) {
                            Text(pokemon.name ?? "")
                                .padding(.vertical, 8)
                                .onAppear {
                                    viewModel.loadMoreData(currentIndex: index)
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .navigationTitle("Pokémon")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Search") {
                            router.push(to: .search)
                        }
                    }
                }
                .onAppear {
                    if viewModel.pokeList.isEmpty {
                        viewModel.loadInitialData()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            viewModel.loadMoreData(currentIndex: 10, ignoreOffset: true)
                        }
                    }
                }
                
                if viewModel.loading {
                    ShimmerView(isPresented: $viewModel.loading)
                }
            }
        }
    }
}

#Preview {
    HomeView(viewModel: DependencyContainer.shared.provideHomeViewModel())
}
