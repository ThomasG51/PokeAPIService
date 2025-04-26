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

    /// Get a list of Pokemon
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokemon = try await Pokemon.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many Pokemon as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokemon = try await Pokemon.selectAll(count: 151)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many Pokemon you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokemon = try await Pokemon.selectAll(from: 151, count: 100)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters offset: The pagination offset
    /// - Parameters limit: The pagination limit
    /// - Returns: A list of Pokemon
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Pokemon] {
        let apiResources = try await lightResources(from: offset, count: limit)
        let pokemonList = try await withThrowingTaskGroup(of: Pokemon.self, returning: [Pokemon].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Pokemon]()) { $0.append($1) }
        }
        return pokemonList.sorted { $0.id < $1.id }
    }

    /// Get a Pokemon using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokemonID: Int = 1
    ///         let bulbasaur = try await Pokemon.selectOne(by: pokemonID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The Pokemon ID
    /// - Returns: A Pokemon
    ///
    public static func selectOne(by id: Int) async throws -> Pokemon {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a Pokemon using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokemonName = "pikachu"
    ///         let pikachu = try await Pokemon.selectOne(by: pokemonName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The Pokemon name
    /// - Returns: A Pokemon
    ///
    public static func selectOne(by name: String) async throws -> Pokemon {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of Pokemon light resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let lightResources = try await Pokemon.lightResources(from: 0, count: 151)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters offset: The pagination offset
    /// - Parameters limit: The pagination limit
    /// - Returns: A list of light resources containing only an ID, a name and a type
    ///
    public static func lightResources(from offset: Int, count limit: Int) async throws -> [LightResource] {
        let params = ["offset": String(offset), "limit": String(limit)]
        let baseResult = try await PokeAPIService<APIResult>.fetchData(from: .list(rootPath: resourceRootPath), with: params)
        return baseResult.resources
    }
}
