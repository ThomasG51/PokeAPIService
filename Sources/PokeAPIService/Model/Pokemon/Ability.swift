//
//  Ability.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

import Foundation

// MARK: - Model

/// Model for Ability API Resource
///
public struct Ability: Decodable {
    public let id: Int
    public let name: String
    public let isMainSeries: Bool
    public let generation: BaseResource
    public let names: [Name]
    public let effectEntries: [VerboseEffect]
    public let effectChanges: [AbilityEffectChange]
    public let flavorTextEntries: [AbilityFlavorText]
    public let pokemon: [AbilityPokemon]
}

// MARK: - Nested Types

public extension Ability {
    struct AbilityEffectChange: Decodable {
        public let effectEntries: [Effect]
        public let versionGroup: BaseResource
    }

    struct AbilityFlavorText: Decodable {
        public let flavorText: String
        public let language: BaseResource
        public let versionGroup: BaseResource
    }

    struct AbilityPokemon: Decodable {
        public let isHidden: Bool
        public let slot: Int
        public let pokemon: BaseResource
    }
}
