//
//  Version.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/03/2025.
//

import Foundation

// MARK: - Model

/// Model for Version API Resource
///
public struct Version: Decodable {
    public let id: Int
    public let name: String
    public let names: [Name]
    public let versionGroup: LightResource
}
