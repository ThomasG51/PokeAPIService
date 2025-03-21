//
//  Pokemon+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/02/2025.
//

import Foundation

extension Pokemon: PokeAPIResource {
    /// The Pokemon API resource root path
    ///
    static var resourceRootPath = "pokemon"

    /// Get a list of Pokemon based on pagination
    ///
    /// - Parameters offset: Pagination offset
    /// - Parameters limit: Pagination limit
    /// - Returns: an array of `Pokemon`
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Pokemon] {
        let apiResources = try await baseResources(from: offset, count: limit)
        let pokemonList = try await withThrowingTaskGroup(of: Pokemon.self, returning: [Pokemon].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Pokemon]()) { $0.append($1) }
        }
        return pokemonList.sorted { $0.id < $1.id }
    }

    /// Get a Pokemon using its id
    ///
    /// - Parameter id: The Pokemon ID
    /// - Returns: a `Pokemon`
    ///
    public static func selectOne(by id: Int) async throws -> Pokemon {
        try await PokeAPIService<Pokemon>.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a Pokemon using its name
    ///
    /// - Parameter name: The Pokemon name
    /// - Returns: a `Pokemon`
    ///
    public static func selectOne(by name: String) async throws -> Pokemon {
        try await PokeAPIService<Pokemon>.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of Pokemon API base resources
    ///
    /// - Parameters offset: Pagination offset
    /// - Parameters limit: Pagination limit
    /// - Returns: an array of `BaseResource` containing a name and an ID
    ///
    public static func baseResources(from offset: Int, count limit: Int) async throws -> [BaseResource] {
        let params = ["offset": String(offset), "limit": String(limit)]
        let baseResult = try await PokeAPIService<BaseResult>.fetchData(from: .list(rootPath: resourceRootPath), with: params)
        return baseResult.resources
    }
}
