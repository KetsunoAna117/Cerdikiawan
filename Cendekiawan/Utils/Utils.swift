//
//  Utils.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 25/06/24.
//

import Foundation

struct Utils {
    static func splitTextWithBlanks(_ text: String) -> [String] {
        var result = [String]()
        let components = text.components(separatedBy: "_")
        
        for (index, component) in components.enumerated() {
            result.append(component)
            if index < components.count - 1 {
                result.append("_")
            }
        }
        return result
    }
    
    static func splitTextIntoPairs(text: String) -> [(String, String)] {
        var pairs: [(String, String)] = []
        let items = text.components(separatedBy: ". ")
        
        for item in items {
            let parts = item.components(separatedBy: ": ")
            if parts.count == 2 {
                let title = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let description = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
                pairs.append((title, description))
            }
        }
        
        return pairs
    }
}
