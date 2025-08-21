//
//  PokemonDetail.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

struct PokeDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [String]
    let imageUrl: String
}
