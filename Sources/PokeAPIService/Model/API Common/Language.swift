//
//  Language.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

import Foundation

/// Model for Language API Resource
///
public struct Language: Decodable {
    public let id: Int
    public let name: String
    public let official: Bool
    public let iso639: String
    public let iso3166: String
    public let names: [Name]
}
