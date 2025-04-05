//
//  GameVersion.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/03/2025.
//

import Foundation

struct GameVersion: Decodable {
    let id: Int
    let name: String
    let names: [NameLanguage]
    let versionGroup: BaseResource

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case names
        case versionGroup = "version_group"
    }
}
