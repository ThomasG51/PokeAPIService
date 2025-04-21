//
//  VerboseEffect.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

import Foundation

/// Model for VerboseEffect API Resource
///
public struct VerboseEffect: Decodable {
    public let effect: String
    public let shortEffect: String
    public let language: BaseResource
}
