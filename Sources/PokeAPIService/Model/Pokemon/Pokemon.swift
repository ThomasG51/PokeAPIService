//
//  Pokemon.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/02/2025.
//

import Foundation

// MARK: - Model

public struct Pokemon: Decodable {
    public let id: Int
    public let name: String
    public let baseExperience: Int
    public let height: Int
    public let isDefault: Bool
    public let order: Int
    public let weight: Int
    public let abilities: [Ability]
    public let formsURLs: [BaseResource]
    public let gameIndices: [VersionGameIndex]
    public let heldItems: [HeldItem]
    public let locationAreaEncounters: String
    public let moves: [Move]
    public let pastTypes: [TypePast]
    public let sprites: Sprites
    public let cries: Cries
    public let species: BaseResource
    public let stats: [Stat]
    public let types: [PokemonType]

    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case order
        case weight
        case abilities
        case formsURLs = "forms"
        case gameIndices = "game_indices"
        case heldItems = "held_items"
        case locationAreaEncounters = "location_area_encounters"
        case moves
        case pastTypes = "past_types"
        case sprites
        case cries
        case species
        case stats
        case types
    }
}

// MARK: - Nested Types

public extension Pokemon {
    struct Ability: Decodable {
        public let isHidden: Bool
        public let slot: Int
        public let abilityURL: BaseResource

        public enum CodingKeys: String, CodingKey {
            case isHidden = "is_hidden"
            case slot
            case abilityURL = "ability"
        }
    }

    struct HeldItem: Decodable {
        public let item: BaseResource
        public let versionDetails: [HeldItemVersionDetail]

        public enum CodingKeys: String, CodingKey {
            case item
            case versionDetails = "version_details"
        }
    }

    struct HeldItemVersionDetail: Decodable {
        public let version: BaseResource
        public let rarity: Int
    }

    struct Move: Decodable {
        public let move: BaseResource
        public let versionGroupDetails: [MoveVersion]

        enum CodingKeys: String, CodingKey {
            case move
            case versionGroupDetails = "version_group_details"
        }
    }

    struct MoveVersion: Decodable {
        public let moveLearnMethod: BaseResource
        public let versionGroup: BaseResource
        public let levelLearnedAt: Int

        enum CodingKeys: String, CodingKey {
            case moveLearnMethod = "move_learn_method"
            case versionGroup = "version_group"
            case levelLearnedAt = "level_learned_at"
        }
    }

    struct TypePast: Decodable {
        public let generation: BaseResource
        public let types: [PokemonType]
    }

    struct PokemonType: Decodable {
        public let slot: Int
        public let type: BaseResource
    }

    struct Sprites: Decodable {
        public let frontDefault: String
        public let frontShiny: String
        public let frontFemale: String?
        public let frontShinyFemale: String?
        public let backDefault: String
        public let backShiny: String
        public let backFemale: String?
        public let backShinyFemale: String?

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
            case frontFemale = "front_female"
            case frontShinyFemale = "front_shiny_female"
            case backDefault = "back_default"
            case backShiny = "back_shiny"
            case backFemale = "back_female"
            case backShinyFemale = "back_shiny_female"
        }
    }

    struct Cries: Decodable {
        public let latest: String
        public let legacy: String
    }

    struct Stat: Decodable {
        public let stat: BaseResource
        public let effort: Int
        public let baseStat: Int

        enum CodingKeys: String, CodingKey {
            case stat
            case effort
            case baseStat = "base_stat"
        }
    }
}
