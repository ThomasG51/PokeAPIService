//
//  Version+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/03/2025.
//

import Foundation

extension Version: PokeAPIResource {
    /// The Version API resource root path
    ///
    internal static var resourceRootPath = "version"

    /// Get a list of Version
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let version = try await Version.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many Version as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let version = try await Version.selectAll(count: 2)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many Version you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let version = try await Version.selectAll(from: 1, count: 3)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter offset: The pagination offset
    /// - Parameter limit: The pagination limit
    /// - Returns: A list of Version
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Version] {
        let apiResources = try await lightResources(from: offset, count: limit)
        let versions = try await withThrowingTaskGroup(of: Version.self, returning: [Version].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Version]()) { $0.append($1) }
        }
        return versions.sorted { $0.id < $1.id }
    }

    /// Get a Version using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let versionID: Int = 3
    ///         let yellow = try await Version.selectOne(by: versionID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The Version ID
    /// - Returns: A Version
    ///
    public static func selectOne(by id: Int) async throws -> Version {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a Version using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let versionName = "yellow"
    ///         let yellow = try await Version.selectOne(by: versionName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The Version name
    /// - Returns: A Version
    ///
    public static func selectOne(by name: String) async throws -> Version {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of Version light resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let lightResources = try await Version.lightResources(from: 0, count: 3)
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
