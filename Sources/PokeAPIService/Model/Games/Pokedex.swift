//
//  Pokedex.swift
//  PokeAPIService
//
//  Created by Thomas George on 25/03/2025.
//

import Foundation

/// Model for Pokedex API Resource
///
public struct Pokedex: Decodable {
    public let id: Int
    public let name: String
    public let isMainSeries: Bool
    public let descriptions: [DescriptionLanguage]
    public let names: [NameLanguage]
    public let pokemonEntries: [PokemonEntry]
    public let region: BaseResource?
    public let versionGroups: [BaseResource]
}

// MARK: - Nested Types

public extension Pokedex {
    struct PokemonEntry: Decodable {
        public let entryNumber: Int
        public let pokemonSpecies: BaseResource
    }
}
