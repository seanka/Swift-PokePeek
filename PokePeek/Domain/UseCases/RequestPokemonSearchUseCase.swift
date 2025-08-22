//
//  RequestPokemonSearchUseCase.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import RxSwift

protocol RequestSearchPokemonUseCase {
    func execute(keyword: String) -> Observable<[Pokemon]>
}

final class RequestSearchPokemonInteractor: RequestSearchPokemonUseCase {
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func execute(keyword: String) -> Observable<[Pokemon]> {
        repository.requestSearchPokemon(keyword: keyword)
    }
}
