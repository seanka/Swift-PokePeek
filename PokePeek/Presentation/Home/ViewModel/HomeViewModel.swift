//
//  HomeViewModel.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import Foundation
import RxSwift
import RxRelay

final class HomeViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    
    @Published var loading = false
    @Published var error: Error? = nil
    @Published var pokeList: [Pokemon] = []
    
    private var offset: Int = 0
    private var limit: Int = 10
    private var totalCount: Int = 0
    
    private let pokeListUseCase: RequestPokemonListUseCase
    
    init(pokeListUseCase: RequestPokemonListUseCase) {
        self.pokeListUseCase = pokeListUseCase
    }
    
    // MARK: - Pagination Functions
    func loadInitialData() {
        offset = 0
        pokeList = []
        requestPokeList()
    }
    
    func loadMoreData(currentIndex: Int) {
        guard !loading else { return }
        
        let thresholdIndex = pokeList.count - 5
        if currentIndex == thresholdIndex {
            if pokeList.count < totalCount {
                requestPokeList()
            }
        }
    }
    
    // MARK: - Pokemon List
    func requestPokeList() {
        loading = true
        
        pokeListUseCase.execute(offset: offset, limit: limit)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    guard let self = self else { return }
                    
                    self.totalCount = response.count ?? 0
                    self.offset += self.limit
                    
                    self.pokeList.append(contentsOf: response.results ?? [])
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
