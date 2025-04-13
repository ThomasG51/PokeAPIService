//
//  BerryFlavor.swift
//  PokeAPIService
//
//  Created by Thomas George on 13/04/2025.
//

import Foundation

public struct BerryFlavor: Decodable {
    public let id: Int
    public let name: String
    public let berries: [FlavorBerryMap]
    public let contestType: BaseResource
    public let names: [NameLanguage]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case berries
        case contestType = "contest_type"
        case names
    }
}

public extension BerryFlavor {
    struct FlavorBerryMap: Decodable {
        public let potency: Int
        public let berry: BaseResource
    }
}
