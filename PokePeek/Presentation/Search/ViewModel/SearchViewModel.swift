//
//  SearchViewModel.swift
//  PokePeek
//
//  Created by Sean Anderson on 22/08/25.
//

import Foundation
import RxSwift
import RxRelay

final class SearchViewModel: ObservableObject {
    @Published var loading = false
    @Published var error: Error? = nil
    @Published var searchKey: String = ""
    @Published var searchResult: [Pokemon] = []
    
    private let pokeSearchUseCase: RequestSearchPokemonUseCase
    
    init(pokeSearchUseCase: RequestSearchPokemonUseCase) {
        self.pokeSearchUseCase = pokeSearchUseCase
    }
    
    // MARK: - Pokemon Search
    func requestPokemonSeach(keyword: String) {
        guard keyword.count >= 3 else {
            searchResult = []
            return
        }
        
        loading = true
        
        pokeSearchUseCase.execute(keyword: keyword)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    guard let self else { return }
                    
                    self.searchResult = response
                },
                onError: { [weak self] error in
                    guard let self else { return }
                    self.error = error
                },
                onCompleted: { [weak self] in
                    guard let self else { return }
                    self.loading = false
                }
            )
    }
}
