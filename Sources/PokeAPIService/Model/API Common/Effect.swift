//
//  Effect.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

import Foundation

/// Model for Effect API Resource
///
public struct Effect: Decodable {
    public let effect: String
    public let language: BaseResource
}
