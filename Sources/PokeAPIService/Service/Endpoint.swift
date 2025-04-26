//
//  Endpoint.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/02/2025.
//

internal enum Endpoint {
    case list(rootPath: String)
    case resource(rootPath: String, value: String)

    var path: String {
        switch self {
        case let .list(rootPath):
            rootPath
        case let .resource(rootPath, value):
            rootPath + "/" + value
        }
    }
}
