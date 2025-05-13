//
//  PokeathlonStat.swift
//  PokeAPIService
//
//  Created by Thomas George on 08/05/2025.
//

import Foundation

// MARK: - Model

/// Model for PokeathlonStat API Resource
///
public struct PokeathlonStat: Decodable {
    public let id: Int
    public let name: String
    public let names: [Name]
    public let affectingNatures: NaturePokeathlonStatAffectSets
}

// MARK: - Nested Types

public extension PokeathlonStat {
    struct NaturePokeathlonStatAffectSets: Decodable {
        public let increase: [NaturePokeathlonStatAffect]
        public let decrease: [NaturePokeathlonStatAffect]

        public struct NaturePokeathlonStatAffect: Decodable {
            public let maxChange: Int
            public let nature: LightResource
        }
    }
}
