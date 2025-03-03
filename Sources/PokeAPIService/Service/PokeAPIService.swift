// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

struct PokeAPIService<T> where T: Decodable {
    // MARK: - Function

    /// <#Description#>
    ///
    /// - Parameter endpointPath: <#endpointPath description#>
    /// - Returns: <#description#>
    ///
    static func fetchData(of path: String, with params: [String: String]? = nil) async throws -> T {
        let url = try constructURL(with: "\(path)", and: params)
        let data = try await data(from: url)
        return try decode(data)
    }

    // MARK: - Private Function

    /// <#Description#>
    ///
    /// - Parameter path: <#path description#>
    /// - Returns: <#description#>
    ///
    private static func constructURL(with path: String, and params: [String: String]?) throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pokeapi.co"
        urlComponents.path = "/api/v2/\(path)"

        if let params {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents.url else {
            throw PokeAPIServiceError.invalidURL
        }

        return url
    }

    /// <#Description#>
    ///
    /// - Parameter url: <#url description#>
    /// - Returns: <#description#>
    ///
    private static func data(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw PokeAPIServiceError.dataRequestFailed
        }

        if httpResponse.statusCode != 200 {
            throw PokeAPIServiceError.httpStatusCodeError(httpResponse.statusCode)
        }

        return data
    }

    /// <#Description#>
    ///
    /// - Parameter data: <#data description#>
    /// - Returns: <#description#>
    ///
    private static func decode(_ data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw PokeAPIServiceError.decoding(error)
        }
    }
}

// MARK: - PokeAPIServiceError

enum PokeAPIServiceError: Error {
    case invalidURL
    case dataRequestFailed
    case httpStatusCodeError(Int)
    case decoding(Error)
}
