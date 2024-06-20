//
//  Trophy.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class Trophy {
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    func getValue() -> Int {
        return value
    }
    
    func setValue(value: Int) {
        self.value = value
    }
    
}
