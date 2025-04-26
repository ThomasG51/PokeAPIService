//
//  Berry.swift
//  PokeAPIService
//
//  Created by Thomas George on 05/04/2025.
//

import Foundation

// MARK: - Model

/// Model for Berry API Resource
///
public struct Berry: Decodable {
    public let id: Int
    public let name: String
    public let growthTime: Int
    public let maxHarvest: Int
    public let naturalGiftPower: Int
    public let size: Int
    public let smoothness: Int
    public let soilDryness: Int?
    public let firmness: LightResource
    public let flavors: [BerryFlavorMap]
    public let item: LightResource
    public let naturalGiftType: LightResource
}

// MARK: - Nested Types

public extension Berry {
    struct BerryFlavorMap: Decodable {
        public let potency: Int
        public let flavor: LightResource
    }
}
