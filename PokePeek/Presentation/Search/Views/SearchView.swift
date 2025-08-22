//
//  SearchView.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Search your favorite Pokémon...", text: $viewModel.searchKey)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: viewModel.searchKey) { key in
                        viewModel.requestPokemonSeach(keyword: key)
                    }
                
                List {
                    ForEach(viewModel.searchResult, id: \.name ) { pokemon in
                        Button(action: {
                            router.push(to: .detail(pokemonName: pokemon.name ?? ""))
                        }) {
                            Text(pokemon.name ?? "")
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationTitle("Search")
            
            if viewModel.loading {
                ShimmerView(isPresented: $viewModel.loading)
            }
        }
    }
}

#Preview {
    SearchView(viewModel: DependencyContainer.shared.provideSearchViewModel())
}
