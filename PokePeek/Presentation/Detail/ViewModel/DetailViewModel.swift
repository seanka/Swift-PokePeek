//
//  DetailViewModel.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import Foundation
import RxSwift
import RxRelay

final class DetailViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    
    @Published var loading = false
    @Published var error: Error? = nil
    @Published var pokeDetail: PokeDetail = PokeDetail()
    
    private let pokeDetailUseCase: RequestPokemonDetailUseCase
    
    init(pokeDetailUseCase: RequestPokemonDetailUseCase) {
        self.pokeDetailUseCase = pokeDetailUseCase
    }
    
    // MARK: - Pokemon Detail
    func requestPokemonDetail(name: String) {
        loading = true
        
        pokeDetailUseCase.execute(name: name)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    guard let self = self else { return }
                    
                    self.pokeDetail = response
                },
                onError: { [weak self] (error: Error) in
                    guard let self = self else { return }
                    self.error = error
                },
                onCompleted: { [weak self] in
                    self?.loading = false
                }
            )
            .disposed(by: disposeBag)
    }
}
