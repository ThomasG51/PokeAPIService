//
//  GrowthRate+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 03/05/2025.
//

import Foundation

extension GrowthRate: PokeAPIResource {
    /// The GrowthRate API resource root path
    ///
    internal static var resourceRootPath = "growth-rate"

    /// Get a list of GrowthRate
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let growthRates = try await GrowthRate.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many GrowthRate as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let growthRates = try await GrowthRate.selectAll(count: 6)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many GrowthRate you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let growthRates = try await GrowthRate.selectAll(from: 2, count: 4)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter offset: The pagination offset
    /// - Parameter limit: The pagination limit
    /// - Returns: A list of GrowthRate
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [GrowthRate] {
        let apiResources = try await lightResources(from: offset, count: limit)
        let growthRateList = try await withThrowingTaskGroup(of: GrowthRate.self, returning: [GrowthRate].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [GrowthRate]()) { $0.append($1) }
        }
        return growthRateList.sorted { $0.id < $1.id }
    }

    /// Get a GrowthRate using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let growthRateID: Int = 1
    ///         let slow = try await GrowthRate.selectOne(by: growthRateID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The GrowthRate ID
    /// - Returns: A GrowthRate
    ///
    public static func selectOne(by id: Int) async throws -> GrowthRate {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a GrowthRate using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let growthRateName = "slow"
    ///         let slow = try await GrowthRate.selectOne(by: growthRateName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The GrowthRate name
    /// - Returns: A GrowthRate
    ///
    public static func selectOne(by name: String) async throws -> GrowthRate {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of GrowthRate light resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let lightResources = try await GrowthRate.lightResources(from: 0, count: 3)
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
