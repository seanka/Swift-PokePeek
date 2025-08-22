//
//  PokemonRepositoryImpl.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import RxSwift

final class PokemonRepositoryImpl: PokemonRepository {
    private let remote: PokemonRemote
    
    init(remote: PokemonRemote) {
        self.remote = remote
    }
    
    func requestPokemonList(offset: Int, limit: Int) -> Observable<PokeList> {
        remote.requestPokemonList(offset: offset, limit: limit)
    }
    
    func requestPokemonDetail(name: String) -> Observable<PokeDetail> {
        remote.requestPokemonDetail(name: name)
    }
    
    func requestSearchPokemon(keyword: String) -> Observable<[Pokemon]> {
        remote.requestSearchPokemon(keyword: keyword)
    }
}
