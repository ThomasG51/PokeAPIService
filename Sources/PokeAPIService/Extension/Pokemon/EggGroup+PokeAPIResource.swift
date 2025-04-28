//
//  EggGroup+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 27/04/2025.
//

import Foundation

extension EggGroup: PokeAPIResource {
    /// The Characteristic API resource root path
    ///
    internal static var resourceRootPath = "egg-group"

    /// Get a list of EggGroup
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let eggGroups = try await EggGroup.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many EggGroup as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let eggGroups = try await EggGroup.selectAll(count: 15)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many EggGroup you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let eggGroups = try await EggGroup.selectAll(from: 5, count: 10)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter offset: The pagination offset
    /// - Parameter limit: The pagination limit
    /// - Returns: A list of EggGroup
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [EggGroup] {
        let apiResources = try await lightResources(from: offset, count: limit)
        let eggGroupList = try await withThrowingTaskGroup(of: EggGroup.self, returning: [EggGroup].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [EggGroup]()) { $0.append($1) }
        }
        return eggGroupList.sorted { $0.id < $1.id }
    }

    /// Get a EggGroup using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let eggGroupID: Int = 1
    ///         let eggGroup = try await EggGroup.selectOne(by: eggGroupID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The EggGroup ID
    /// - Returns: A EggGroup
    ///
    public static func selectOne(by id: Int) async throws -> EggGroup {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a EggGroup using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let eggGroupName = "monster"
    ///         let monster = try await EggGroup.selectOne(by: eggGroupName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The EggGroup name
    /// - Returns: A EggGroup
    ///
    public static func selectOne(by name: String) async throws -> EggGroup {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of EggGroup light resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let lightResources = try await EggGroup.lightResources(from: 0, count: 15)
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
