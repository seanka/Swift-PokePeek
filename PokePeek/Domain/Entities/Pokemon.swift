//
//  Pokemon.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

struct PokeList: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Pokemon]?
}

struct Pokemon: Codable {
    var name: String?
    var url: String?
}
