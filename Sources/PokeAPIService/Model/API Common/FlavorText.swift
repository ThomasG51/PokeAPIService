//
//  FlavorText.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

import Foundation

/// Model for FlavorText API Resource
///
public struct FlavorText: Decodable {
    public let flavorText: String
    public let language: BaseResource
    public let version: BaseResource
}
