//
//  DescriptionLanguage.swift
//  PokeAPIService
//
//  Created by Thomas George on 25/03/2025.
//

import Foundation

/// Model for DescriptionLanguage API Resource
///
public struct DescriptionLanguage: Decodable {
    public let description: String
    public let language: BaseResource
}
