//
//  BerryFlavor.swift
//  PokeAPIService
//
//  Created by Thomas George on 13/04/2025.
//

import Foundation

// MARK: - Model

/// Model for BerryFlavor API Resource
///
public struct BerryFlavor: Decodable {
    public let id: Int
    public let name: String
    public let berries: [FlavorBerryMap]
    public let contestType: LightResource
    public let names: [Name]
}

// MARK: - Nested Types

public extension BerryFlavor {
    struct FlavorBerryMap: Decodable {
        public let potency: Int
        public let berry: LightResource
    }
}
