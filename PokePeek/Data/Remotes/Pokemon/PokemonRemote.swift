//
//  PokemonRemote.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import Alamofire
import RxSwift

final class PokemonRemote {
    private let baseURL = "https://pokeapi.co/api/v2"
    
    func requestPokemonList(offset: Int, limit: Int) -> Observable<PokeList> {
        return Observable.create { observer in
            let url = self.baseURL + PokemonAPI.pokemon  + "?limit=\(limit)&offset=\(offset)"
            
            let request = AF.request(url).responseDecodable(of: PokeList.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func requestPokemonDetail(name: String) -> Observable<PokeDetail> {
        return Observable.create { observer in
            let url = self.baseURL + PokemonAPI.pokemon  + "/\(name)"
            
            let request = AF.request(url).responseDecodable(of: PokeDetail.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func requestSearchPokemon(keyword: String) -> Observable<PokeList> {
        return Observable.create { observer in
            let url = self.baseURL + PokemonAPI.pokemon  + "/\(keyword)"
            
            let request = AF.request(url).responseDecodable(of: PokeList.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
