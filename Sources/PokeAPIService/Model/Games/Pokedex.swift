//
//  Pokedex.swift
//  PokeAPIService
//
//  Created by Thomas George on 25/03/2025.
//

import Foundation

public struct Pokedex: Decodable {
    public let id: Int
    public let name: String
    public let isMainSeries: Bool
    public let descriptions: [DescriptionLanguage]
    public let names: [NameLanguage]
    public let pokemonEntries: [PokemonEntry]
    public let region: BaseResource?
    public let versions: [BaseResource]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isMainSeries = "is_main_series"
        case descriptions
        case names
        case pokemonEntries = "pokemon_entries"
        case region
        case versions = "version_groups"
    }
}

public extension Pokedex {
    struct PokemonEntry: Decodable {
        public let entryNumber: Int
        public let pokemonSpecies: BaseResource

        enum CodingKeys: String, CodingKey {
            case entryNumber = "entry_number"
            case pokemonSpecies = "pokemon_species"
        }
    }
}
