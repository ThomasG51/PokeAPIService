// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

struct PokeAPIService<T> where T: Decodable {
    // MARK: - Function

    /// Fetch data from a URL
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
            throw PokeAPIServiceError.invalidURL
        }

        return url
    }

    /// The data fetched from a URL
    ///
    /// - Parameter url: The related URL
    /// - Returns: The fetched data
    ///
    private static func data(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw PokeAPIServiceError.invalidResponse
        }

        if httpResponse.statusCode == 404 {
            throw PokeAPIServiceError.notFound
        }

        if httpResponse.statusCode != 200 {
            let message = String(data: data, encoding: String.Encoding.utf8) ?? "No description"
            throw PokeAPIServiceError.httpStatusCodeError(code: httpResponse.statusCode, message: message)
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
            throw PokeAPIServiceError.decoding(description: error.localizedDescription)
        }
    }
}

// MARK: - PokeAPIServiceError

enum PokeAPIServiceError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case notFound
    case httpStatusCodeError(code: Int, message: String)
    case decoding(description: String)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .invalidResponse:
            "Invalid response"
        case .notFound:
            "Not found"
        case .httpStatusCodeError(code: let code, message: let message):
            "HTTP status code: \(code), message: \(message)"
        case .decoding(let description):
            "Decoding Error : \(description)"
        }
    }
}
