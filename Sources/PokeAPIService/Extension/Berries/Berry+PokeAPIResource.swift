//
//  Berry+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 05/04/2025.
//

extension Berry: PokeAPIResource {
    /// The Pokemon API resource root path
    ///
    static var resourceRootPath = "berry"

    /// Get a list of Berry
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let berries = try await Berry.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many Berry as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let berries = try await Berry.selectAll(count: 5)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many Berry you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let berries = try await Berry.selectAll(from: 10, count: 20)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters offset: The pagination offset
    /// - Parameters limit: The pagination limit
    /// - Returns: A list of Berry
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Berry] {
        let apiResources = try await baseResources(from: offset, count: limit)
        let berries = try await withThrowingTaskGroup(of: Berry.self, returning: [Berry].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Berry]()) { $0.append($1) }
        }
        return berries.sorted { $0.id < $1.id }
    }

    /// Get a Berry using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryID: Int = 1
    ///         let cheri = try await Berry.selectOne(by: berryID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The Berry ID
    /// - Returns: A Berry
    ///
    public static func selectOne(by id: Int) async throws -> Berry {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a Berry using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let berryName = "cheri"
    ///         let cheri = try await Berry.selectOne(by: berryName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The Berry name
    /// - Returns: A Berry
    ///
    public static func selectOne(by name: String) async throws -> Berry {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of Berry API base resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let baseResources = try await Berry.baseResources(from: 0, count: 3)
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
