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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Spacer()
                    pokeImage
                    Spacer()
                }
                
                HStack {
                    Text("#\(viewModel.pokeDetail.id ?? -1)")
                        .font(.system(size: 32, weight: .bold))
                    Spacer()
                    Text(viewModel.pokeDetail.name?.capitalized ?? "")
                        .font(.system(size: 32, weight: .bold))
                }
                
                typeSection
                Divider()
                abilitySection
                
                Divider()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Height: \(viewModel.pokeDetail.height ?? 0)")
                    Text("Weight: \(viewModel.pokeDetail.weight ?? 0)")
                    Text("Base Experience: \(viewModel.pokeDetail.base_experience ?? 0)")
                }
                .font(.subheadline)
            }
            .padding()
        }
        .navigationTitle(viewModel.pokeDetail.name?.capitalized ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.requestPokemonDetail(name: pokemonName)
        }
    }
}

extension DetailView {
    private var pokeImage: some View {
        AsyncImage(url: URL(string: viewModel.pokeDetail.sprites?.other?.showdown?.front_shiny ?? "")) { image in
            image.resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)
        } placeholder: {
            ProgressView()
        }
    }
    
    private var typeSection: some View {
        HStack {
            ForEach(viewModel.pokeDetail.types ?? [], id: \.slot) { type in
                Text(type.type?.name?.capitalized ?? "")
                    .font(.subheadline)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
        }
    }
    
    private var abilitySection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Abilities")
                .font(.headline)
            
            ForEach(viewModel.pokeDetail.abilities ?? [], id: \.slot) { ability in
                HStack {
                    Text(ability.ability?.name?.capitalized ?? "")
                    
                    if ability.is_hidden == true {
                        Text("(Hidden)")
                            .foregroundColor(.gray)
                            .italic()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    DetailView(viewModel: DependencyContainer.shared.provideDetailViewModel(), pokemonName: "")
}
