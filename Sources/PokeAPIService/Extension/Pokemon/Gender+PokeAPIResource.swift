//
//  Gender+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/04/2025.
//

import Foundation

extension Gender: PokeAPIResource {
    /// The Gender API resource root path
    ///
    internal static var resourceRootPath = "gender"

    /// Get a list of Gender
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let genders = try await Gender.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many Gender as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let genders = try await Gender.selectAll(count: 3)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many Gender you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let genders = try await Gender.selectAll(from: 1, count: 2)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter offset: The pagination offset
    /// - Parameter limit: The pagination limit
    /// - Returns: A list of Gender
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Gender] {
        let apiResources = try await lightResources(from: offset, count: limit)
        let genderList = try await withThrowingTaskGroup(of: Gender.self, returning: [Gender].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Gender]()) { $0.append($1) }
        }
        return genderList.sorted { $0.id < $1.id }
    }

    /// Get a Gender using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let genderID: Int = 1
    ///         let female = try await Gender.selectOne(by: genderID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The Gender ID
    /// - Returns: A Gender
    ///
    public static func selectOne(by id: Int) async throws -> Gender {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get a Gender using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let genderName = "female"
    ///         let female = try await Gender.selectOne(by: genderName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The Gender name
    /// - Returns: A Gender
    ///
    public static func selectOne(by name: String) async throws -> Gender {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of Gender light resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let lightResources = try await Gender.lightResources(from: 0, count: 3)
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
