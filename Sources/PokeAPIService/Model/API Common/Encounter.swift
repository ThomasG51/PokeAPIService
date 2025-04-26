//
//  Encounter.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

import Foundation

/// Model for Encounter API Resource
///
public struct Encounter: Decodable {
    public let minLevel: Int
    public let maxLevel: Int
    public let conditionValues: [LightResource]
    public let chance: Int
    public let method: LightResource
}
