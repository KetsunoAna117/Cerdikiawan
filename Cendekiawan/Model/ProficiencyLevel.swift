//
//  ProficiencyLevel.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 22/06/24.
//

import SwiftUI

class ProficiencyLevel {
    @AppStorage("levelIdePokok") var idePokok: Int = 5
    @AppStorage("levelKosakata") var kosakata: Int = 5
    @AppStorage("levelImplisit") var implisit: Int = 5
}

class ProficiencyLevelStorage {
    var idePokok: Int
    var kosakata: Int
    var implisit: Int
    
    init(idePokok: Int = 5, kosakata: Int = 5, implisit: Int = 5) {
        self.idePokok = idePokok
        self.kosakata = kosakata
        self.implisit = implisit
    }
}
