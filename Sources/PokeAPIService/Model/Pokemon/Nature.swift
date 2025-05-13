//
//  Nature.swift
//  PokeAPIService
//
//  Created by Thomas George on 07/05/2025.
//

import Foundation

// MARK: - Model

/// Model for Ability API Resource
///
public struct Nature: Decodable {
    public let id: Int
    public let name: String
    public let decreasedStat: LightResource?
    public let increasedStat: LightResource?
    public let hatesFlavor: LightResource?
    public let likesFlavor: LightResource?
    public let pokeathlonStatChanges: [NatureStatChange]
    public let moveBattleStylePreferences: [MoveBattleStylePreference]
    public let names: [Name]
}

// MARK: - Nested Types

public extension Nature {
    struct NatureStatChange: Decodable {
        public let maxChange: Int
        public let pokeathlonStat: LightResource
    }

    struct MoveBattleStylePreference: Decodable {
        public let lowHpPreference: Int
        public let highHpPreference: Int
        public let moveBattleStyle: LightResource
    }
}
