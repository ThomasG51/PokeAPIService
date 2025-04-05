//
//  GameVersionGroup.swift
//  PokeAPIService
//
//  Created by Thomas George on 05/04/2025.
//

import Foundation

struct GameVersionGroup: Decodable {
    let id: Int
    let name: String
    let order: Int
    let generation: BaseResource
    let moveLearnMethods: [BaseResource]
    let pokedexes: [BaseResource]
    let regions: [BaseResource]
    let versions: [BaseResource]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case order
        case generation
        case moveLearnMethods = "move_learn_methods"
        case pokedexes
        case regions
        case versions
    }
}
