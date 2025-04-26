//
//  PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 01/03/2025.
//

// periphery:ignore:all - Use to disable wrong `unused` or `redundant` warning for this protocol

import Foundation

internal protocol PokeAPIResource where Self: Decodable {
    static var resourceRootPath: String { get }

    static func selectAll(from offset: Int, count limit: Int) async throws -> [Self]
    static func selectOne(by id: Int) async throws -> Self
    static func selectOne(by name: String) async throws -> Self
    static func lightResources(from offset: Int, count limit: Int) async throws -> [LightResource]
}
