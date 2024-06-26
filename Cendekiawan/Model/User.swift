//
//  User.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 20/06/24.
//

import SwiftUI

//cara pakenya tinggal declare stateobject si class User trus ubah aja user.exp udh auto update kalo ada Text(), atau jadiin published di VM lebih bagus sih
class User: ObservableObject {
    let levelStorage = Level()
    let levelDifficulty = DifficultyLevel()
    let levelProficiency = ProficiencyLevel()
    
    @Published var name: String
    
    @Published var exp: Int {
        didSet {
            let check = levelStorage.updateLevel(exp)
            if check {
                exp = levelStorage.exp  // Reset exp after level up
            }
        }
    }
    
    @Published var difficultyLevel: Int {
        didSet {
            levelDifficulty.difficultyLevel = difficultyLevel
        }
    }
    
    @Published var proficiencyLevelIdePokok: Int {
        didSet {
            levelProficiency.idePokok = proficiencyLevelIdePokok
        }
    }
    
    @Published var proficiencyLevelKosakata: Int {
        didSet {
            levelProficiency.kosakata = proficiencyLevelKosakata
        }
    }
    
    @Published var proficiencyLevelImplisit: Int {
        didSet {
            levelProficiency.implisit = proficiencyLevelImplisit
        }
    }
    
    init(name: String) {
        self.name = name
        self.exp = levelStorage.exp
        self.difficultyLevel = levelDifficulty.difficultyLevel
        self.proficiencyLevelIdePokok = levelProficiency.idePokok
        self.proficiencyLevelKosakata = levelProficiency.kosakata
        self.proficiencyLevelImplisit = levelProficiency.implisit
    }
}
