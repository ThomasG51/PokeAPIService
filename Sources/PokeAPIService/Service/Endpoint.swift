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
                    return "pokemon"
                case .one(let value):
                    return "pokemon/\(value)"
                }
            }
        }
    }
}
