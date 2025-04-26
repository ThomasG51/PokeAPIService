//
//  Generation+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/03/2025.
//

import Foundation

extension Generation: PokeAPIResource {
    /// The Generation API resource root path
    ///
    static var resourceRootPath = "generation"

    /// Get a list of Generation
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let generation = try await Generation.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many Generation as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let generation = try await Generation.selectAll(count: 2)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many Generation you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let generation = try await Generation.selectAll(from: 1, count: 3)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters offset: The pagination offset
    /// - Parameters limit: The pagination limit
    /// - Returns: A list of Generation
    ///
    static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Generation] {
        let apiResources = try await lightResources(from: offset, count: limit)
        let generations = try await withThrowingTaskGroup(of: Generation.self, returning: [Generation].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Generation]()) { $0.append($1) }
        }
        return generations.sorted { $0.id < $1.id }
    }

    /// Get a Generation using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let generationID: Int = 1
    ///         let firstGeneration = try await Generation.selectOne(by: generationID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The Generation ID
    /// - Returns: A Generation
    ///
    public static func selectOne(by id: Int) async throws -> Generation {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a Generation using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let generationName = "generation-i"
    ///         let firstGeneration = try await Pokedex.selectOne(by: generationName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The Generation name
    /// - Returns: A Generation
    ///
    public static func selectOne(by name: String) async throws -> Generation {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of Generation light resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let lightResources = try await Generation.lightResources(from: 0, count: 3)
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
