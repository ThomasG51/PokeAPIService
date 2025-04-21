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
    public let abilities: [BaseResource]
    public let names: [Name]
    public let mainRegion: BaseResource
    public let moves: [BaseResource]
    public let pokemonSpecies: [BaseResource]
    public let types: [BaseResource]
    public let versionGroups: [BaseResource]
}
