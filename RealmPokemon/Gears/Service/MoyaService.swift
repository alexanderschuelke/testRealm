//
//  PokemonService.swift
//  RealmPokemon
//
//  Created by Alexander Schülke on 01.10.18.
//  Copyright © 2018 Alexander Schülke. All rights reserved.
//

import Foundation
import Moya

enum MoyaService {
    case getPokemon(number: String)
}

extension MoyaService: TargetType {
    var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2/pokemon")!
    }
    
    var path: String {
        switch self {
        case .getPokemon(let number):
            return "/\(number)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPokemon(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPokemon(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
}

public class APIService {
    
    let pokemonProvider = MoyaProvider<MoyaService>()
    
    func fetchPokemon(with number: Int, completion: @escaping (Pokemon) -> Void) {
        pokemonProvider.request(.getPokemon(number: String(number))) { (result) in
            
            switch result {
            case .success:
                let pokemon = try! JSONDecoder().decode(Pokemon.self, from: result.value!.data)
                completion(pokemon)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
