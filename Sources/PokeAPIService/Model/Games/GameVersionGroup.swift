//
//  GameVersionGroup.swift
//  PokeAPIService
//
//  Created by Thomas George on 05/04/2025.
//

import Foundation

/// Model for GameVersionGroup API Resource
///
public struct GameVersionGroup: Decodable {
    public let id: Int
    public let name: String
    public let order: Int
    public let generation: BaseResource
    public let moveLearnMethods: [BaseResource]
    public let pokedexes: [BaseResource]
    public let regions: [BaseResource]
    public let versions: [BaseResource]

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
