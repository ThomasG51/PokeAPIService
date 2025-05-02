//
//  Gender.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/04/2025.
//

import Foundation

/// Model for Gender API Resource
///
public struct Gender: Decodable {
    public let id: Int
    public let name: String
    public let pokemonSpeciesDetails: [PokemonSpeciesGender]
    public let requiredForEvolution: [LightResource]
}

// MARK: - Nested Types

public extension Gender {
    struct PokemonSpeciesGender: Decodable {
        public let rate: Int
        public let pokemonSpecies: LightResource
    }
}
