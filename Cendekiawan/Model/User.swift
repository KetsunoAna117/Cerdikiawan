//
//  User.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 20/06/24.
//

import SwiftUI

//cara pakenya tinggal declare stateobject si class User trus ubah aja user.exp udh auto update kalo ada Text()
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
    
    func updateIdePokokProeficiency(win: Bool){
        if win {
            proficiencyLevelIdePokok += 1
            proficiencyLevelIdePokok %= 10
        } else {
            proficiencyLevelIdePokok -= 1
            if proficiencyLevelIdePokok < 0{
                proficiencyLevelIdePokok = 0
            }
        }
        checkLevel()
    }
    
    func updateImplisitProeficiency(win: Bool){
        if win {
            proficiencyLevelImplisit += 1
            proficiencyLevelImplisit %= 10
        } else {
            proficiencyLevelImplisit -= 1
            if proficiencyLevelImplisit < 0{
                proficiencyLevelImplisit = 0
            }
        }
    }
    
    func updateKosakataProeficiency(win: Bool){
        if win {
            proficiencyLevelKosakata += 1
            proficiencyLevelKosakata %= 10
        } else {
            proficiencyLevelKosakata -= 1
            if proficiencyLevelKosakata < 0{
                proficiencyLevelKosakata = 0
            }
        }
    }
    
    func checkLevel(){
        if proficiencyLevelImplisit == 10 &&
            proficiencyLevelIdePokok == 10 &&
            proficiencyLevelKosakata == 10{
            difficultyLevel += 1
            difficultyLevel %= 6
        } else if proficiencyLevelImplisit < 3 &&
            proficiencyLevelIdePokok < 3 &&
            proficiencyLevelKosakata < 3{
            difficultyLevel -= 1
            if difficultyLevel < 4{
                difficultyLevel = 4
            }
        }
    }
}
