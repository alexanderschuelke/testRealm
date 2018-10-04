//
//  ListViewModel.swift
//  RealmPokemon
//
//  Created by Alexander Schülke on 01.10.18.
//  Copyright © 2018 Alexander Schülke. All rights reserved.
//

import Foundation
import RealmSwift

class ListViewModel {
    
    let apiService: APIService
    
    // Representatiom of Realm storage
    var storedPokemon: Results<PokemonModel>!
    
    // Observer for changes in realm
    var notificationToken: NotificationToken?
    
    public init(apiService: APIService = APIService()) {
        self.apiService = apiService
        
        // Fetch Pokemon from realm
        let realm = RealmService.shared.realm
        storedPokemon = realm.objects(PokemonModel.self)
    }
    
    public func fetch(number: Int) {
        self.apiService.fetchPokemon(with: number) { (pokemon) in
            self.processPokemon(pokemon)
        }
    }
    
    // Create a new realm object
    private func processPokemon(_ pokemon: Pokemon) {
        let pokemonModel = PokemonModel(name: pokemon.name + "ääää", id: pokemon.number, height: pokemon.height, weight: pokemon.weight)
        RealmService.shared.create(pokemonModel)
    }
    
    // Get a specific CellView from stored realm data
    public func getStoredPokemon(for indexPath: IndexPath) -> PokemonCellViewModel {
        let pokemonCellViewModel = PokemonCellViewModel(pokemonModel: storedPokemon[indexPath.row])
        return pokemonCellViewModel
    }
    
    
    public func deletePokemon(at indexPath: IndexPath) {
        let pokemonModel = storedPokemon[indexPath.row]
        RealmService.shared.delete(pokemonModel)
    }
    
    // Call this from view to insert the table reload into callback
    public func startObserving(callback: @escaping () -> Void) {
        let realm = RealmService.shared.realm
        
        notificationToken = realm.observe({ (notification, realm) in
            callback()
        })
    }
    
}

// Cell view model
struct PokemonCellViewModel {
    
    var name: String
    var number: String
    var weight: String
    var height: String
    
    public init(pokemonModel: PokemonModel) {
        self.name = pokemonModel.name
        self.number = String("Nr. \(pokemonModel.id.value!)ääää")
        self.weight = String("\(pokemonModel.weight.value! / 10) kg")
        self.height = String("\(pokemonModel.height.value! / 10) m")
    }
    
}
