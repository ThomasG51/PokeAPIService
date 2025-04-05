//
//  GameVersionGroup+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 05/04/2025.
//

import Foundation

extension GameVersionGroup: PokeAPIResource {
    /// The GameVersionGroup API resource root path
    ///
    static var resourceRootPath = "version-group"

    /// Get a list of GameVersionGroup
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let gameVersionGroups = try await GameVersionGroup.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many GameVersionGroup as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let gameVersionGroups = try await GameVersionGroup.selectAll(count: 2)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many GameVersionGroup you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let gameVersionGroups = try await GameVersionGroup.selectAll(from: 1, count: 3)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters offset: The pagination offset
    /// - Parameters limit: The pagination limit
    /// - Returns: A list of GameVersionGroup
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [GameVersionGroup] {
        let apiResources = try await baseResources(from: offset, count: limit)
        let gameVersionGroups = try await withThrowingTaskGroup(of: GameVersionGroup.self, returning: [GameVersionGroup].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [GameVersionGroup]()) { $0.append($1) }
        }
        return gameVersionGroups.sorted { $0.id < $1.id }
    }

    /// Get a GameVersionGroup using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let gameVersionGroupID: Int = 1
    ///         let redBlue = try await GameVersionGroup.selectOne(by: gameVersionGroupID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The GameVersionGroup ID
    /// - Returns: A GameVersionGroup
    ///
    public static func selectOne(by id: Int) async throws -> GameVersionGroup {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a GameVersionGroup using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let gameVersionGroupName = "red-blue"
    ///         let redBlue = try await GameVersion.selectOne(by: gameVersionGroupName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The GameVersionGroup name
    /// - Returns: A GameVersionGroup
    ///
    public static func selectOne(by name: String) async throws -> GameVersionGroup {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of GameVersionGroup API base resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let baseResources = try await GameVersionGroup.baseResources(from: 0, count: 3)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters offset: The pagination offset
    /// - Parameters limit: The pagination limit
    /// - Returns: A list of light API base resources containing only an ID, a name and a type
    ///
    public static func baseResources(from offset: Int, count limit: Int) async throws -> [BaseResource] {
        let params = ["offset": String(offset), "limit": String(limit)]
        let baseResult = try await PokeAPIService<BaseResult>.fetchData(from: .list(rootPath: resourceRootPath), with: params)
        return baseResult.resources
    }
}
