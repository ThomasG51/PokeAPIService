//
//  GameVersion+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/03/2025.
//

import Foundation

extension GameVersion: PokeAPIResource {
    /// The GameVersion API resource root path
    ///
    static var resourceRootPath = "version"

    /// Get a list of GameVersion
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let gameVersion = try await GameVersion.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many GameVersion as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let gameVersion = try await GameVersion.selectAll(count: 2)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many GameVersion you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let gameVersion = try await GameVersion.selectAll(from: 1, count: 3)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters offset: The pagination offset
    /// - Parameters limit: The pagination limit
    /// - Returns: A list of GameVersion
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [GameVersion] {
        let apiResources = try await baseResources(from: offset, count: limit)
        let gameVersions = try await withThrowingTaskGroup(of: GameVersion.self, returning: [GameVersion].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [GameVersion]()) { $0.append($1) }
        }
        return gameVersions.sorted { $0.id < $1.id }
    }

    /// Get a GameVersion using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let gameVersionID: Int = 3
    ///         let yellow = try await GameVersion.selectOne(by: gameVersionID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The GameVersion ID
    /// - Returns: A GameVersion
    ///
    public static func selectOne(by id: Int) async throws -> GameVersion {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a GameVersion using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let gameVersionName = "yellow"
    ///         let yellow = try await GameVersion.selectOne(by: gameVersionName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The GameVersion name
    /// - Returns: A GameVersion
    ///
    public static func selectOne(by name: String) async throws -> GameVersion {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of GameVersion API base resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let baseResources = try await GameVersion.baseResources(from: 0, count: 3)
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
