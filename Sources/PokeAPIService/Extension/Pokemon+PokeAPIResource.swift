//
//  Pokemon+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/02/2025.
//

import Foundation

extension Pokemon: PokeAPIResource {
    typealias T = Pokemon

    static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Pokemon] {
    /// Get a list of Pokemon based on pagination
    ///
    /// - Parameters offset: Pagination offset
    /// - Parameters limit: Pagination limit
    /// - Returns: an array of `Pokemon`
    ///
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

    static func selectOne(by id: Int) async throws -> Pokemon {
    /// Get a Pokemon using its id
    ///
    /// - Parameter id: The Pokemon ID
    /// - Returns: a `Pokemon`
    ///
        try await PokeAPIService<Pokemon>.fetchData(of: Endpoint.PokemonGroup.Pokemon.one(String(id)).path)
    }

    static func selectOne(by name: String) async throws -> Pokemon {
    /// Get a Pokemon using its name
    ///
    /// - Parameter name: The Pokemon name
    /// - Returns: a `Pokemon`
    ///
        try await PokeAPIService<Pokemon>.fetchData(of: Endpoint.PokemonGroup.Pokemon.one(name).path)
    }

    static func urls(from offset: Int, count limit: Int) async throws -> [String] {
    /// Get a list of Pokemon  resource URLs based on pagination
    ///
    /// - Parameters offset: Pagination offset
    /// - Parameters limit: Pagination limit
    /// - Returns: an array of url in `String` format
    ///
        let params = ["offset": String(offset), "limit": String(limit)]
        let baseResourceList = try await PokeAPIService<BaseResourceList>.fetchData(of: Endpoint.PokemonGroup.Pokemon.list.path, with: params)
        return baseResourceList.urls.reduce(into: [String]()) { $0.append($1.url) }
    }
}
