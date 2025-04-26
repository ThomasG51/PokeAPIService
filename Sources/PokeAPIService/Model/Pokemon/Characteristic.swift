//
//  Characteristic.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

// MARK: - Model

/// Model for Characteristic API Resource
///
public struct Characteristic: Decodable {
    public let id: Int
    public let geneModulo: Int
    public let possibleValues: [Int]
    public let highestStat: LightResource
    public let descriptions: [Description]
}
