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
    
    private let pokeHelper: PokemonDataHelper
    private let pokeListUseCase: RequestPokemonListUseCase
    
    init(pokeHelper: PokemonDataHelper, pokeListUseCase: RequestPokemonListUseCase) {
        self.pokeHelper = pokeHelper
        self.pokeListUseCase = pokeListUseCase
    }
    
    // MARK: - Pagination Functions
    func loadInitialData() {
        offset = 0
        pokeList = []
        requestPokeList()
    }
    
    func loadMoreData(currentIndex: Int, ignoreOffset: Bool = false) {
        guard !ignoreOffset else {
            requestPokeList()
            return
        }
        
        guard !loading else { return }
        
        let thresholdIndex = pokeList.count - 5
        if currentIndex == thresholdIndex {
            if pokeList.count < totalCount {
                requestPokeList()
            }
        }
    }
    
    // MARK: - Local Pokemon List
    func loadCachedPokeList() {
        loading = true
        let cached = pokeHelper.fetchPokeList(offset: offset, limit: limit)
        
        guard let cached else {
            loading = false;
            return
        }
        
        self.pokeList.append(contentsOf: cached)
    }
    
    // MARK: - Pokemon List
    func requestPokeList() {
        loadCachedPokeList()
        
        loading = true
        pokeListUseCase.execute(offset: offset, limit: limit)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    guard let self, let pokeResults = response.results else { return }
                    
                    self.totalCount = response.count ?? 0
                    self.offset += self.limit
                    
                    self.pokeList.append(contentsOf: pokeResults)
                    
                    // Save to Core Data
                    if offset == 0 {
                        pokeHelper.overwriteList(with: pokeResults)
                    } else {
                        pokeHelper.updatePokeList(with: pokeResults)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.loading = false
                    }
                },
                onError: { [weak self] (error: Error) in
                    guard let self else { return }
                    
                    self.error = error
                    self.loading = false
                }
            )
            .disposed(by: disposeBag)
    }
}
