//
//  RequestPokemonDetailUseCase.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import RxSwift

protocol RequestPokemonDetailUseCase {
    func execute(id: Int) -> Observable<PokeDetail>
}

final class RequestPokemonDetailInteractor: RequestPokemonDetailUseCase {
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func execute(id: Int) -> Observable<PokeDetail> {
        repository.requestPokemonDetail(id: id)
    }
}
