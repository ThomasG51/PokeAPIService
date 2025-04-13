//
//  GameVersion.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/03/2025.
//

import Foundation

/// Model for GameVersion API Resource
///
public struct GameVersion: Decodable {
    public let id: Int
    public let name: String
    public let names: [NameLanguage]
    public let versionGroup: BaseResource

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case names
        case versionGroup = "version_group"
    }
}
