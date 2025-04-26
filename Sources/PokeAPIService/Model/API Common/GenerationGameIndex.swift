//
//  GenerationGameIndex.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

import Foundation

/// Model for GenerationGameIndex API Resource
///
public struct GenerationGameIndex: Decodable {
    public let gameIndex: Int
    public let generation: LightResource
}
