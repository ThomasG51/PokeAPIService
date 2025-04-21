//
//  Name.swift
//  PokeAPIService
//
//  Created by Thomas George on 20/03/2025.
//

import Foundation

/// Model for Name API Resource
///
public struct Name: Decodable {
    public let name: String
    public let language: BaseResource
}
