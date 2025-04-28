//
//  EggGroup.swift
//  PokeAPIService
//
//  Created by Thomas George on 27/04/2025.
//

import Foundation

/// Model for EggGroup API Resource
///
public struct EggGroup: Decodable {
    public let id: Int
    public let name: String
    public let names: [Name]
    public let pokemonSpecies: [LightResource]
}
