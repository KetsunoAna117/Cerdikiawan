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
}
