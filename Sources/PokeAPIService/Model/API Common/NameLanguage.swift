//
//  NameLanguage.swift
//  PokeAPIService
//
//  Created by Thomas George on 20/03/2025.
//

import Foundation

/// Model for NameLanguage API Resource
///
public struct NameLanguage: Decodable {
    public let name: String
    public let language: BaseResource
}
