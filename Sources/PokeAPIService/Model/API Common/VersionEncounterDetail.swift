//
//  VersionEncounterDetail.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

import Foundation

/// Model for VersionEncounterDetail API Resource
///
public struct VersionEncounterDetail: Decodable {
    public let version: LightResource
    public let maxChance: Int
    public let encounterDetails: [Encounter]
}
