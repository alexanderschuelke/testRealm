//
//  PokemonModel.swift
//  RealmPokemon
//
//  Created by Alexander Schülke on 01.10.18.
//  Copyright © 2018 Alexander Schülke. All rights reserved.
//

import Foundation
import RealmSwift

class PokemonModel: Object {
    
    // Representation of properties in realm
    @objc dynamic var name: String = ""
    let id = RealmOptional<Int>()
    let weight = RealmOptional<Double>()
    let height = RealmOptional<Double>()
    
    convenience init(name: String, id: Int, height: Double, weight: Double) {
        self.init()
        self.name = name
        self.id.value = id
        self.height.value = height
        self.weight.value = weight
    }
    
}
