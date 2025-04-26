//
//  Generation.swift
//  PokeAPIService
//
//  Created by Thomas George on 20/03/2025.
//

import Foundation

// MARK: - Model

/// Model for Generation API Resource
///
public struct Generation: Decodable {
    public let id: Int
    public let name: String
    public let abilities: [LightResource]
    public let names: [Name]
    public let mainRegion: LightResource
    public let moves: [LightResource]
    public let pokemonSpecies: [LightResource]
    public let types: [LightResource]
    public let versionGroups: [LightResource]
}
