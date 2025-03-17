//
//  Pokemon+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/02/2025.
//

import Foundation

extension Pokemon: PokeAPIResource {
    public typealias T = Pokemon

    /// Get a list of Pokemon based on pagination
    ///
    /// - Parameters offset: Pagination offset
    /// - Parameters limit: Pagination limit
    /// - Returns: an array of `Pokemon`
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Pokemon] {
        let urls = try await urls(from: offset, count: limit)
        let pokemonList = try await withThrowingTaskGroup(of: Pokemon.self, returning: [Pokemon].self) { group in
            for url in urls {
                if let id = Int(url.split(separator: "/").last ?? "") {
                    group.addTask { try await selectOne(by: id) }
                }
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
        try await PokeAPIService<Pokemon>.fetchData(of: Endpoint.PokemonGroup.Pokemon.one(String(id)).path)
    }

    /// Get a Pokemon using its name
    ///
    /// - Parameter name: The Pokemon name
    /// - Returns: a `Pokemon`
    ///
    public static func selectOne(by name: String) async throws -> Pokemon {
        try await PokeAPIService<Pokemon>.fetchData(of: Endpoint.PokemonGroup.Pokemon.one(name).path)
    }

    /// Get a list of Pokemon  resource URLs based on pagination
    ///
    /// - Parameters offset: Pagination offset
    /// - Parameters limit: Pagination limit
    /// - Returns: an array of url in `String` format
    ///
    public static func urls(from offset: Int, count limit: Int) async throws -> [String] {
        let params = ["offset": String(offset), "limit": String(limit)]
        let baseResourceList = try await PokeAPIService<BaseResourceList>.fetchData(of: Endpoint.PokemonGroup.Pokemon.list.path, with: params)
        return baseResourceList.urls.reduce(into: [String]()) { $0.append($1.url) }
    }
}
