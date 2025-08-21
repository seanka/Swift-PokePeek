//
//  RequestPokemonListUsecase.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import RxSwift

protocol RequestPokemonListUseCase {
    func execute(offset: Int, limit: Int) -> Observable<PokeList>
}

final class RequestPokemonListInteractor: RequestPokemonListUseCase {
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func execute(offset: Int, limit: Int) -> Observable<PokeList> {
        repository.requestPokemonList(offset: offset, limit: limit)
    }
}
