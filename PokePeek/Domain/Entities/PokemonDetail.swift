//
//  PokemonDetail.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

struct PokeDetail: Codable {
    var abilities: [Ability]?
    var base_experience: Int?
    var forms: [Detail]?
    var game_indices: [GameIndice]?
    var height: Int?
    var held_items: [HeldItem]?
    var id: Int?
    var is_default: Bool?
    var location_area_encounbters: String?
    var moves: [Move]?
    var name: String?
    var order: Int?
    var pastAbilities: [PastAbility]?
    var sprites: Sprites?
    var stats: [Stat]?
    var types: [Types]?
    var weight: Int?
}

struct Ability: Codable {
    var is_hidden: Bool?
    var slot: Int?
    var ability: Detail?
}

struct Detail: Codable {
    var name: String?
    var url: String?
}

struct GameIndice: Codable {
    var game_index: Int?
    var version: Detail?
}

struct HeldItem: Codable {
    var item: Detail?
    var version_details: [VersionDetail]?
}

struct VersionDetail: Codable {
    var rarity: Int?
    var version: Detail?
}

struct Move: Codable {
    var move: Detail?
    var version_group_details: [VersionGroupDetail]?
}

struct VersionGroupDetail: Codable {
    var level_learned_at: Int?
    var move_learn_method: Detail?
    var version_group: Detail?
}

struct PastAbility: Codable {
    var abilities: [Ability]?
    var generation: Detail?
}

struct Sprites: Codable {
    var back_default: String?
    var back_female: String?
    var back_shiny: String?
    var back_shiny_female: String?
    var front_default: String?
    var front_female: String?
    var front_shiny: String?
    var front_shiny_female: String?
}

struct Stat: Codable {
    var base_stat: Int?
    var effort: Int?
    var stat: Detail?
}

struct Types: Codable {
    var slot: Int?
    var type: Detail?
}
