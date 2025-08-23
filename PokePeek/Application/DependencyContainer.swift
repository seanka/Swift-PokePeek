//
//  DependencyContainer.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import Foundation

final class DependencyContainer {
    static let shared = DependencyContainer()
    
    let userDataHelper: UserDataHelper
    let pokemonRemote: PokemonRemote
    let repository: PokemonRepository
    
    private init() {
        self.userDataHelper = UserDataHelper(context: PersistenceController.shared.container.viewContext)
        self.pokemonRemote = PokemonRemote()
        self.repository = PokemonRepositoryImpl(remote: pokemonRemote)
    }
    
    func provideAppRouter() -> AppRouter {
        AppRouter(userHelper: userDataHelper)
    }
    
    func provideAuthViewModel() -> AuthViewModel {
        AuthViewModel(userHelper: userDataHelper)
    }
    
    func provideHomeViewModel() -> HomeViewModel {
        let pokeListUseCase = RequestPokemonListInteractor(repository: repository)
        
        return HomeViewModel(
            pokeListUseCase: pokeListUseCase
        )
    }
    
    func provideProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(userHelper: userDataHelper)
    }
    
    func provideDetailViewModel() -> DetailViewModel {
        let pokeDetailUseCase = RequestPokemonDetailInteractor(repository: repository)
        
        return DetailViewModel(
            pokeDetailUseCase: pokeDetailUseCase
        )
    }
    
    func provideSearchViewModel() -> SearchViewModel {
        let pokeSearchUseCase = RequestSearchPokemonInteractor(repository: repository)
        
        return SearchViewModel(
            pokeSearchUseCase: pokeSearchUseCase
        )
    }
    
    func providePasswordResetViewModel() -> PasswordResetViewModel {
        PasswordResetViewModel(
            userHelper: userDataHelper
        )
    }
}
