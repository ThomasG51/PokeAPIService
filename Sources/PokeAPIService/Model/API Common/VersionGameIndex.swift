//
//  VersionGameIndex.swift
//  PokeAPIService
//
//  Created by Thomas George on 17/03/2025.
//

import Foundation

/// Model for VersionGameIndex API Resource
///
public struct VersionGameIndex: Decodable {
    public let gameIndex: Int
    public let version: LightResource
}
