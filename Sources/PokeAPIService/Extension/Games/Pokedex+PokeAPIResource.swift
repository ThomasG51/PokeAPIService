//
//  Pokedex+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 25/03/2025.
//

import Foundation

extension Pokedex: PokeAPIResource {
    /// The Pokedex API resource root path
    ///
    internal static var resourceRootPath = "pokedex"

    /// Get a list of Pokedex
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokedex = try await Pokedex.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many Pokedex as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokedex = try await Pokedex.selectAll(count: 3)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many Pokedex you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokedex = try await Pokedex.selectAll(from: 1, count: 4)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter offset: The pagination offset
    /// - Parameter limit: The pagination limit
    /// - Returns: A list of Pokedex
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Pokedex] {
        let apiResources = try await lightResources(from: offset, count: limit)
        let pokedexes = try await withThrowingTaskGroup(of: Pokedex.self, returning: [Pokedex].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Pokedex]()) { $0.append($1) }
        }
        return pokedexes.sorted { $0.id < $1.id }
    }

    /// Get a Pokedex using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokedexID: Int = 2
    ///         let kanto = try await Pokdex.selectOne(by: pokedexID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The Pokedex ID
    /// - Returns: A Pokedex
    ///
    public static func selectOne(by id: Int) async throws -> Pokedex {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a Pokedex using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokedexName = "kanto"
    ///         let kanto = try await Pokedex.selectOne(by: pokemonName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The Pokedex name
    /// - Returns: A Pokedex
    ///
    public static func selectOne(by name: String) async throws -> Pokedex {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of Pokedex light resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let lightResources = try await Pokedex.lightResources(from: 0, count: 3)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter offset: The pagination offset
    /// - Parameter limit: The pagination limit
    /// - Returns: A list of light resources containing only an ID, a name and a type
    ///
    public static func lightResources(from offset: Int, count limit: Int) async throws -> [LightResource] {
        let params = ["offset": String(offset), "limit": String(limit)]
        let baseResult = try await PokeAPIService<APIResult>.fetchData(from: .list(rootPath: resourceRootPath), with: params)
        return baseResult.resources
    }
}
