//
//  GrowthRate.swift
//  PokeAPIService
//
//  Created by Thomas George on 03/05/2025.
//

import Foundation

// MARK: - Model

/// Model for GrowthRate API Resource
///
public struct GrowthRate: Decodable {
    public let id: Int
    public let name: String
    public let formula: String
    public let descriptions: [Description]
    public let levels: [GrowthRateExperienceLevel]
    public let pokemonSpecies: [LightResource]
}

// MARK: - Nested Types

public extension GrowthRate {
    struct GrowthRateExperienceLevel: Decodable {
        public let level: Int
        public let experience: Int
    }
}
