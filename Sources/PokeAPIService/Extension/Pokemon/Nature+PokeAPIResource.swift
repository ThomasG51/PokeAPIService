//
//  Nature+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 07/05/2025.
//

import Foundation

extension Nature: PokeAPIResource {
    /// The Nature API resource root path
    ///
    internal static var resourceRootPath = "nature"

    /// Get a list of Nature
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let natures = try await Nature.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many Nature as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let natures = try await Nature.selectAll(count: 20)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many Nature you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let natures = try await Nature.selectAll(from: 10, count: 15)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter offset: The pagination offset
    /// - Parameter limit: The pagination limit
    /// - Returns: A list of Nature
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Nature] {
        let apiResources = try await lightResources(from: offset, count: limit)
        let natureList = try await withThrowingTaskGroup(of: Nature.self, returning: [Nature].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Nature]()) { $0.append($1) }
        }
        return natureList.sorted { $0.id < $1.id }
    }

    /// Get a Nature using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let natureID: Int = 1
    ///         let hardy = try await Nature.selectOne(by: natureID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The Nature ID
    /// - Returns: A Nature
    ///
    public static func selectOne(by id: Int) async throws -> Nature {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a Nature using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let natureName = "hardy"
    ///         let hardy = try await Nature.selectOne(by: natureName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The Nature name
    /// - Returns: A Nature
    ///
    public static func selectOne(by name: String) async throws -> Nature {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of Nature light resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let lightResources = try await Nature.lightResources(from: 0, count: 25)
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
