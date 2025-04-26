//
//  VersionGroup.swift
//  PokeAPIService
//
//  Created by Thomas George on 05/04/2025.
//

import Foundation

// MARK: - Model

/// Model for VersionGroup API Resource
///
public struct VersionGroup: Decodable {
    public let id: Int
    public let name: String
    public let order: Int
    public let generation: LightResource
    public let moveLearnMethods: [LightResource]
    public let pokedexes: [LightResource]
    public let regions: [LightResource]
    public let versions: [LightResource]
}
