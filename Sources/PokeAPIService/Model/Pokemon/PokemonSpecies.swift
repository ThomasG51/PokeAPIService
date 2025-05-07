//
//  PokemonSpecies.swift
//  PokeAPIService
//
//  Created by Thomas George on 03/05/2025.
//

import Foundation

// MARK: - Model

/// Model for PokemonSpecies API Resource
///
public struct PokemonSpecies: Decodable {
    public let id: Int
    public let name: String
    public let order: Int
    public let genderRate: Int
    public let captureRate: Int
    public let baseHappiness: Int
    public let isBaby: Bool
    public let isLegendary: Bool
    public let isMythical: Bool
    public let hatchCounter: Int
    public let hasGenderDifferences: Bool
    public let formsSwitchable: Bool
    public let growthRate: LightResource
    public let pokedexNumbers: [PokemonSpeciesDexEntry]
    public let eggGroups: [LightResource]
    public let color: LightResource
    public let shape: LightResource
    public let evolvesFromSpecies: LightResource
    public let evolutionChain: LightResource
    public let habitat: LightResource
    public let generation: LightResource
    public let names: [Name]
    public let palParkEncounters: [PalParkEncounterArea]
    public let flavorTextEntries: [FlavorText]
    public let formDescriptions: [Description]
    public let genera: [Genus]
    public let varieties: [PokemonSpeciesVariety]
}

// MARK: - Nested Types

public extension PokemonSpecies {
    struct Genus: Decodable {
        public let genus: String
        public let language: LightResource
    }

    struct PokemonSpeciesDexEntry: Decodable {
        public let entryNumber: Int
        public let pokedex: LightResource
    }

    struct PalParkEncounterArea: Decodable {
        public let baseScore: Int
        public let rate: Int
        public let area: LightResource
    }

    struct PokemonSpeciesVariety: Decodable {
        public let isDefault: Bool
        public let pokemon: LightResource
    }
}
