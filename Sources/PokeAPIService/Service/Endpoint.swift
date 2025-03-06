//
//  Endpoint.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/02/2025.
//

enum Endpoint {
    enum PokemonGroup {
        enum Pokemon {
            case list
            case one(String)

            var path: String {
                switch self {
                case .list:
                    "pokemon"
                case let .one(value):
                    "pokemon/\(value)"
                }
            }
        }
    }

    enum GamesGroup {
        enum Version {
            case list
            case one(String)

            var path: String {
                switch self {
                case .list:
                    "version"
                case let .one(value):
                    "version/\(value)"
                }
            }
        }
    }
}
