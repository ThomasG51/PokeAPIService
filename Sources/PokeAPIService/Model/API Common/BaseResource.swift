//
//  BaseResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 02/03/2025.
//

import Foundation

public struct BaseResource: Codable {
    // MARK: - Public
    
    public var id: String {
        String(url.split(separator: "/").last ?? "")
    }
    
    public let name: String
    
    public var type: String {
        String(url.split(separator: "/").dropLast().last ?? "")
    }
    
    // MARK: - Internal
    
    let url: String
}
