//
//  BerryFirmness+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

import Foundation

extension BerryFirmness: PokeAPIResource {
    /// The Pokemon API resource root path
    ///
    static var resourceRootPath = "berry-firmness"

    /// Get a list of BerryFirmness
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryFirmnesses = try await BerryFirmness.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many BerryFirmness as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryFirmnesses = try await BerryFirmness.selectAll(count: 5)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many BerryFirmness you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryFirmnesses = try await BerryFirmness.selectAll(from: 1, count: 2)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters offset: The pagination offset
    /// - Parameters limit: The pagination limit
    /// - Returns: A list of BerryFirmness
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [BerryFirmness] {
        let apiResources = try await baseResources(from: offset, count: limit)
        let berryFirmnesses = try await withThrowingTaskGroup(of: BerryFirmness.self, returning: [BerryFirmness].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [BerryFirmness]()) { $0.append($1) }
        }
        return berryFirmnesses.sorted { $0.id < $1.id }
    }

    /// Get a BerryFirmness using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryFirmnessID: Int = 1
    ///         let verySoft = try await BerryFirmness.selectOne(by: berryFirmnessID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The BerryFirmness ID
    /// - Returns: A BerryFirmness
    ///
    public static func selectOne(by id: Int) async throws -> BerryFirmness {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a BerryFirmness using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryFirmnessName = "very-soft"
    ///         let verySoft = try await BerryFirmness.selectOne(by: berryFirmnessName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The BerryFirmness name
    /// - Returns: A BerryFirmness
    ///
    public static func selectOne(by name: String) async throws -> BerryFirmness {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of BerryFirmnesses API base resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let baseResources = try await BerryFirmness.baseResources(from: 0, count: 3)
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
