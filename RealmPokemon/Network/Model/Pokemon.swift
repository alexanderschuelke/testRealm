//
//  Pokemon.swift
//  RealmPokemon
//
//  Created by Alexander Schülke on 01.10.18.
//  Copyright © 2018 Alexander Schülke. All rights reserved.
//

import Foundation

class Pokemon: Decodable {
    
      var name: String
      var number: Int
      var height: Double
      var weight: Double
    //  var firstType: String
   //   var secondType: String?
    
    enum PokemonDefaultKeys: String, CodingKey {
       case forms
       case name
       case number = "id"
       case height
       case weight
     //  case types
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonDefaultKeys.self)
        let forms = try container.decode([[String:String]].self, forKey: .forms)
        self.name = forms.first!["name"]!
        self.number = try container.decode(Int.self, forKey: .number)
        self.height = try container.decode(Double.self, forKey: .height)
        self.weight = try container.decode(Double.self, forKey: .weight)
       // let typies = try container.decode([[String:Any]].self, forKey: .types)
        
    }
    
}
