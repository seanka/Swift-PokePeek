//
//  DetailView.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject var viewModel: DetailViewModel
    
    public var pokemonName: String
    
    init(viewModel: DetailViewModel, pokemonName: String) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.pokemonName = pokemonName
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(pokemonName)
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            Text(String(viewModel.pokeDetail.weight ?? 0))
        }
        .navigationTitle(pokemonName.capitalized)
        .navigationBarBackButtonHidden(false)
        .onAppear {
            viewModel.requestPokemonDetail(name: pokemonName)
        }
    }
}

#Preview {
    DetailView(viewModel: DependencyContainer.shared.provideDetailViewModel(), pokemonName: "")
}
