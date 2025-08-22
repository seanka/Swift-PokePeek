//
//  PokemonRepository.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import RxSwift

protocol PokemonRepository {
    func requestPokemonList(offset: Int, limit: Int) -> Observable<PokeList>
    func requestPokemonDetail(name: String) -> Observable<PokeDetail>
    func requestSearchPokemon(keyword: String) -> Observable<[Pokemon]>
}
