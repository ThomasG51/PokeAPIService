//
//  BerryFlavor+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 13/04/2025.
//

import Foundation

extension BerryFlavor: PokeAPIResource {
    /// The Pokemon API resource root path
    ///
    internal static var resourceRootPath = "berry-flavor"

    /// Get a list of BerryFlavor
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryFlavors = try await BerryFlavor.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many BerryFlavor as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryFlavors = try await BerryFlavor.selectAll(count: 5)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many BerryFlavor you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryFlavors = try await BerryFlavor.selectAll(from: 2, count: 3)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter offset: The pagination offset
    /// - Parameter limit: The pagination limit
    /// - Returns: A list of BerryFlavor
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [BerryFlavor] {
        let apiResources = try await lightResources(from: offset, count: limit)
        let berryFlavors = try await withThrowingTaskGroup(of: BerryFlavor.self, returning: [BerryFlavor].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [BerryFlavor]()) { $0.append($1) }
        }
        return berryFlavors.sorted { $0.id < $1.id }
    }

    /// Get a BerryFlavor using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryFlavorID: Int = 1
    ///         let spicy = try await BerryFlavor.selectOne(by: berryFlavorID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The BerryFlavor ID
    /// - Returns: A BerryFlavor
    ///
    public static func selectOne(by id: Int) async throws -> BerryFlavor {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a BerryFlavor using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryFlavorName = "spicy"
    ///         let spicy = try await BerryFlavor.selectOne(by: berryFlavorName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The BerryFlavor name
    /// - Returns: A BerryFlavor
    ///
    public static func selectOne(by name: String) async throws -> BerryFlavor {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of BerryFlavor light resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let lightResources = try await BerryFlavor.lightResources(from: 0, count: 3)
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
