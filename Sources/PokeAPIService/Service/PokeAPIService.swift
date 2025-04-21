// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import OSLog

struct PokeAPIService<T> where T: Decodable {
    // MARK: - Function

    /// Fetch and return decoded data from a URL
    ///
    /// - Parameter endpoint: The resource endpoint
    /// - Parameter params: The parameters to construct the URL
    /// - Returns: The data decoded in the right object type
    ///
    static func fetchData(from endpoint: Endpoint, with params: [String: String]? = nil) async throws -> T {
        let url = try constructURL(with: endpoint, and: params)
        let data = try await data(from: url)
        return try decode(data)
    }

    // MARK: - Private Function

    /// Construct a URL with a path and parameters
    ///
    /// - Parameter endpoint: The resource endpoint
    /// - Parameter params: The parameters for the URL
    /// - Returns: a non optional URL
    ///
    private static func constructURL(with endpoint: Endpoint, and params: [String: String]?) throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pokeapi.co"
        urlComponents.path = "/api/v2/\(endpoint.path)"

        if let params {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents.url else {
            PokeLogger.critical("Invalid URL !")
            throw PokeAPIServiceError.invalidURL
        }

        return url
    }

    /// Handle data and  HTTP response
    ///
    /// - Parameter url: The related URL
    /// - Returns: The fetched data
    ///
    private static func data(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            PokeLogger.critical("Invalid response !")
            throw PokeAPIServiceError.invalidResponse
        }

        if httpResponse.statusCode != 200 {
            PokeLogger.response(httpResponse, data.prettyPrinted)
            if httpResponse.statusCode == 404 {
                throw PokeAPIServiceError.notFound
            } else {
                throw PokeAPIServiceError.httpStatusCodeError(code: httpResponse.statusCode, message: data.prettyPrinted)
            }
        }

        return data
    }

    /// Decode data in the right object type
    ///
    /// - Parameter data: The data to decode
    /// - Returns: The decoded object
    ///
    private static func decode(_ data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            PokeLogger.decoding(error)
            throw PokeAPIServiceError.decoding
        }
    }

    // MARK: - Init

    private init() {}
}

// MARK: - PokeAPIServiceError

enum PokeAPIServiceError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case notFound
    case httpStatusCodeError(code: Int, message: String)
    case decoding

    // periphery:ignore - wrong `unused` warning, the property is used on line 94 and also by the client app
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .invalidResponse:
            "Invalid response"
        case .notFound:
            "Not found"
        case let .httpStatusCodeError(code: code, message: message):
            "HTTP status code: \(code), message: \(message)"
        case .decoding:
            "Decoding Error"
        }
    }
}
