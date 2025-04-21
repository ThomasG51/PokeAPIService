//
//  GameVersionGroup+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 05/04/2025.
//

import Foundation

extension VersionGroup: PokeAPIResource {
    /// The VersionGroup API resource root path
    ///
    static var resourceRootPath = "version-group"

    /// Get a list of VersionGroup
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let versionGroups = try await VersionGroup.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many VersionGroup as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let versionGroups = try await VersionGroup.selectAll(count: 2)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many VersionGroup you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let versionGroups = try await VersionGroup.selectAll(from: 1, count: 3)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters offset: The pagination offset
    /// - Parameters limit: The pagination limit
    /// - Returns: A list of VersionGroup
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [VersionGroup] {
        let apiResources = try await baseResources(from: offset, count: limit)
        let versionGroups = try await withThrowingTaskGroup(of: VersionGroup.self, returning: [VersionGroup].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [VersionGroup]()) { $0.append($1) }
        }
        return versionGroups.sorted { $0.id < $1.id }
    }

    /// Get a VersionGroup using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let versionGroupID: Int = 1
    ///         let redBlue = try await VersionGroup.selectOne(by: versionGroupID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The VersionGroup ID
    /// - Returns: A VersionGroup
    ///
    public static func selectOne(by id: Int) async throws -> VersionGroup {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a VersionGroup using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let versionGroupName = "red-blue"
    ///         let redBlue = try await GameVersion.selectOne(by: versionGroupName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The VersionGroup name
    /// - Returns: A VersionGroup
    ///
    public static func selectOne(by name: String) async throws -> VersionGroup {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of VersionGroup API base resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let baseResources = try await VersionGroup.baseResources(from: 0, count: 3)
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
        let baseResult = try await PokeAPIService<APIResult>.fetchData(from: .list(rootPath: resourceRootPath), with: params)
        return baseResult.resources
    }
}
