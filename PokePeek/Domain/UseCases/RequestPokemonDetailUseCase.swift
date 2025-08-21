//
//  RequestPokemonDetailUseCase.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import RxSwift

protocol RequestPokemonDetailUseCase {
    func execute(name: String) -> Observable<PokeDetail>
}

final class RequestPokemonDetailInteractor: RequestPokemonDetailUseCase {
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func execute(name: String) -> Observable<PokeDetail> {
        repository.requestPokemonDetail(name: name)
    }
}
