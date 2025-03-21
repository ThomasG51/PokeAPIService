//
//  Generation.swift
//  PokeAPIService
//
//  Created by Thomas George on 20/03/2025.
//

import Foundation

public struct Generation: Decodable {
    public let id: Int
    public let name: String
    public let abilities: [BaseResource]
    public let names: [NameLanguage]
    public let mainRegion: BaseResource
    public let moves: [BaseResource]
    public let pokemonSpecies: [BaseResource]
    public let types: [BaseResource]
    public let versions: [BaseResource]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case abilities
        case names
        case mainRegion = "main_region"
        case moves
        case pokemonSpecies = "pokemon_species"
        case types
        case versions = "version_groups"
    }
}
