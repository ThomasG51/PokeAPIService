//
//  PokeLogger.swift
//  PokeAPIService
//
//  Created by Thomas George on 05/04/2025.
//

import Foundation
import OSLog

struct PokeLogger {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "PokeAPIService", category: "PokeAPIService")

    static func info(_ message: String) {
        #if DEBUG
            logger.info("\(message)")
        #endif
    }

    static func warning(_ message: String) {
        #if DEBUG
            logger.warning("\(message)")
        #endif
    }

    static func critical(_ message: String) {
        #if DEBUG
            logger.critical("\(message)")
        #endif
    }

    static func response(_ response: HTTPURLResponse, _ body: String? = nil) {
        #if DEBUG
            var description = """
            🧑‍🚀 RESPONSE:
            ------------
            URL: \(response.url?.absoluteString ?? "URL not found")
            Status Code: \(response.statusCode)
            """

            if let body {
                description += "\nBody: \(body)"
            }

            switch response.statusCode {
            case 200:
                info(description)
            case 404:
                warning(description)
            default:
                critical(description)
            }
        #endif
    }

    static func decoding(_ error: Error) {
        #if DEBUG
            let description = switch error {
            case let DecodingError.dataCorrupted(context):
                """
                👾 DECODING:
                ------------
                Data Corrupted
                Debug Description: \(context.debugDescription)
                """
            case let DecodingError.keyNotFound(key, context):
                """
                👾 DECODING:
                ------------
                Key \(key.stringValue) not found
                Debug Description: \(context.debugDescription)
                Coding Path: \(context.codingPath)
                """
            case let DecodingError.valueNotFound(value, context):
                """
                👾 DECODING:
                ------------
                Value of type \(value) not found
                Debug Description: \(context.debugDescription)
                Coding Path: \(context.codingPath)
                """
            case let DecodingError.typeMismatch(type, context):
                """
                👾 DECODING:
                ------------
                Type \(type) mismatch
                Debug Description: \(context.debugDescription)
                Coding Path: \(context.codingPath)
                """
            default:
                error.localizedDescription
            }
            critical(description)
        #endif
    }

    private init() {}
}
