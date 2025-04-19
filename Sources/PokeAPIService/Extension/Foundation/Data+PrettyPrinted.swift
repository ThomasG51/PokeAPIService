//
//  Data+PrettyPrinted.swift
//  PokeAPIService
//
//  Created by Thomas George on 20/04/2025.
//

import Foundation

extension Data {
    var prettyPrinted: String {
        let string = if let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
                        let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
        {
            String(data: data, encoding: .utf8)
        } else {
            String(data: self, encoding: .utf8)
        }
        return string ?? "Unable to print Data"
    }
}
