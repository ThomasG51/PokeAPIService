//
//  Characteristic+PokeAPiResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

extension Characteristic: PokeAPIResource {
    /// The Characteristic API resource root path
    ///
    internal static var resourceRootPath = "characteristic"

    /// Get a list of Characteristic
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let characteristics = try await Characteristic.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many Characteristic as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let characteristics = try await Characteristic.selectAll(count: 151)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many Characteristic you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let characteristics = try await Characteristic.selectAll(from: 151, count: 100)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter offset: The pagination offset
    /// - Parameter limit: The pagination limit
    /// - Returns: A list of Pokemon
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Characteristic] {
        let apiResources = try await lightResources(from: offset, count: limit)
        let characteristicList = try await withThrowingTaskGroup(of: Characteristic.self, returning: [Characteristic].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Characteristic]()) { $0.append($1) }
        }
        return characteristicList.sorted { $0.id < $1.id }
    }

    /// Get a Characteristic using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let characteristicID: Int = 1
    ///         let characteristic = try await Characteristic.selectOne(by: characteristicID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The Characteristic ID
    /// - Returns: A Characteristic
    ///
    public static func selectOne(by id: Int) async throws -> Characteristic {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// This function should not be used outside the package.
    /// "Characteristic model has no `name` property. Use `selectOne(by: id)` instead."
    ///
    internal static func selectOne(by name: String) async throws -> Characteristic {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of Characteristic light resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let lightResources = try await Characteristic.lightResources(from: 0, count: 30)
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
