//
//  RealmService.swift
//  RealmPokemon
//
//  Created by Alexander Schülke on 01.10.18.
//  Copyright © 2018 Alexander Schülke. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func create(_ object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary{
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    
    
}
