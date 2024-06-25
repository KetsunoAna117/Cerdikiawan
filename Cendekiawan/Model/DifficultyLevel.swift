//
//  DifficultyLevel.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 23/06/24.
//

import SwiftUI

class DifficultyLevel {
    @AppStorage("levelDifficulty") var difficultyLevel: Int = 4
}

class DifficultyLevelStorage {
    var difficultyLevel: Int = 4
}
