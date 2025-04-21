//
//  VersionGroup.swift
//  PokeAPIService
//
//  Created by Thomas George on 05/04/2025.
//

import Foundation

/// Model for VersionGroup API Resource
///
public struct VersionGroup: Decodable {
    public let id: Int
    public let name: String
    public let order: Int
    public let generation: BaseResource
    public let moveLearnMethods: [BaseResource]
    public let pokedexes: [BaseResource]
    public let regions: [BaseResource]
    public let versions: [BaseResource]
}
