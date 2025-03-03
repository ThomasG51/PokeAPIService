//
//  Pokemon.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/02/2025.
//

import Foundation

// MARK: - Model

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let isDefault: Bool
    let order: Int
    let weight: Int
    let abilities: [Ability]
    let formsURLs: [BaseResource]
    let heldItems: [HeldItem]
    let locationAreaEncounters: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case order
        case weight
        case abilities
        case formsURLs = "forms"
        case heldItems = "held_items"
        case locationAreaEncounters = "location_area_encounters"
    }
}

// MARK: - Nested Types

extension Pokemon {
    struct Ability: Decodable {
        let isHidden: Bool
        let slot: Int
        let abilityURL: BaseResource

        enum CodingKeys: String, CodingKey {
            case isHidden = "is_hidden"
            case slot
            case abilityURL = "ability"
        }
    }

    struct HeldItem: Decodable {
        let item: BaseResource
        let versionDetails: HeldItemVersionDetail

        enum CodingKeys: String, CodingKey {
            case item
            case versionDetails = "version_details"
        }
    }

    struct HeldItemVersionDetail: Decodable {
        let version: BaseResource
        let rarity: Int
    }
}
