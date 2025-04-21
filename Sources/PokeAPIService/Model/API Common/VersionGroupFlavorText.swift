//
//  VersionGroupFlavorText.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

import Foundation

/// Model for VersionGroupFlavorText API Resource
///
public struct VersionGroupFlavorText: Decodable {
    public let text: String
    public let lamguage: BaseResource
    public let versionGroup: BaseResource
}
