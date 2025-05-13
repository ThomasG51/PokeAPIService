//
//  PokeathlonStat+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 13/05/2025.
//

import Foundation

extension PokeathlonStat: PokeAPIResource {
    /// The Pokemon API resource root path
    ///
    internal static var resourceRootPath = "pokeathlon-stat"

    /// Get a list of PokeathlonStat
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokeathlonStats = try await PokeathlonStat.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many PokeathlonStat as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokeathlonStats = try await PokeathlonStat.selectAll(count: 5)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many PokeathlonStat you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokeathlonStats = try await PokeathlonStat.selectAll(from: 2, count: 3)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter offset: The pagination offset
    /// - Parameter limit: The pagination limit
    /// - Returns: A list of PokeathlonStat
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [PokeathlonStat] {
        let apiResources = try await lightResources(from: offset, count: limit)
        let pokeathlonStatList = try await withThrowingTaskGroup(of: PokeathlonStat.self, returning: [PokeathlonStat].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [PokeathlonStat]()) { $0.append($1) }
        }
        return pokeathlonStatList.sorted { $0.id < $1.id }
    }

    /// Get a PokeathlonStat using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokeathlonStatID: Int = 1
    ///         let speed = try await PokeathlonStat.selectOne(by: pokeathlonStatID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The PokeathlonStat ID
    /// - Returns: A PokeathlonStat
    ///
    public static func selectOne(by id: Int) async throws -> PokeathlonStat {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a PokeathlonStat using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let pokeathlonStatName = "speed"
    ///         let speed = try await PokeathlonStat.selectOne(by: pokeathlonStatName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The PokeathlonStat name
    /// - Returns: A PokeathlonStat
    ///
    public static func selectOne(by name: String) async throws -> PokeathlonStat {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of PokeathlonStat light resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let lightResources = try await PokeathlonStat.lightResources(from: 0, count: 5)
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
