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

    static func debug(_ message: String) {
        #if DEBUG
            logger.debug("\(message)")
        #endif
    }

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

    private init() {}
}
