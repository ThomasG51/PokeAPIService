//
//  Description.swift
//  PokeAPIService
//
//  Created by Thomas George on 25/03/2025.
//

import Foundation

/// Model for Description API Resource
///
public struct Description: Decodable {
    public let description: String
    public let language: BaseResource
}
