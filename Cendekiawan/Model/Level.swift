//
//  Level.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 20/06/24.
//

import SwiftUI

class Level {
    @AppStorage("levelValue") var value: Int = 1
    @AppStorage("levelExp") var exp: Int = 0
    @AppStorage("levelBoundaries") var boundaries: Int = 10
    
    func updateLevel(_ exp: Int) -> Bool {
        if exp >= self.boundaries {
            self.boundaries += 10
            value += 1
            self.exp = 0  // Reset stored exp after level up
            return true
        }
        self.exp = exp
        return false
    }
}
