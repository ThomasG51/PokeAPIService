//
//  BerryFirmness.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

import Foundation

// MARK: - Model

/// Model for BerryFirmness API Resource
///
public struct BerryFirmness: Decodable {
    public let id: Int
    public let name: String
    public let berries: [LightResource]
    public let names: [Name]
}
