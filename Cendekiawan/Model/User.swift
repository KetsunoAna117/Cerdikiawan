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
}

func updateIdePokokProeficiency(user: User, win: Bool){
    if win {
        user.proficiencyLevelIdePokok += 1
        if user.proficiencyLevelIdePokok > 10{
            user.proficiencyLevelIdePokok = 10
        }
    } else {
        user.proficiencyLevelIdePokok -= 1
        if user.proficiencyLevelIdePokok < 0{
            user.proficiencyLevelIdePokok = 0
        }
    }
    checkLevel(user: user)
}

func updateImplisitProeficiency(user: User, win: Bool){
    if win {
        user.proficiencyLevelImplisit += 1
        if user.proficiencyLevelImplisit > 10{
            user.proficiencyLevelImplisit = 10
        }
    } else {
        user.proficiencyLevelImplisit -= 1
        if user.proficiencyLevelImplisit < 0{
            user.proficiencyLevelImplisit = 0
        }
    }
    checkLevel(user: user)
}

func updateKosakataProeficiency(user: User, win: Bool){
    if win {
        user.proficiencyLevelKosakata += 1
        if user.proficiencyLevelKosakata > 10{
            user.proficiencyLevelKosakata = 10
        }
    } else {
        user.proficiencyLevelKosakata -= 1
        if user.proficiencyLevelKosakata < 0{
            user.proficiencyLevelKosakata = 0
        }
    }
    checkLevel(user: user)
}

func checkLevel(user: User){
    
    if user.proficiencyLevelImplisit == 10 &&
        user.proficiencyLevelIdePokok == 10 &&
        user.proficiencyLevelKosakata == 10{
        user.difficultyLevel += 1
        if user.difficultyLevel > 6{
            user.difficultyLevel = 6
            } else {
                user.proficiencyLevelImplisit = 5
                user.proficiencyLevelIdePokok = 5
                user.proficiencyLevelKosakata = 5
            }
    } else if user.proficiencyLevelImplisit < 3 &&
                user.proficiencyLevelIdePokok < 3 &&
                user.proficiencyLevelKosakata < 3{
        
        user.difficultyLevel -= 1
        if user.difficultyLevel < 4{
            user.difficultyLevel = 4
        } else {
            user.proficiencyLevelImplisit = 5
            user.proficiencyLevelIdePokok = 5
            user.proficiencyLevelKosakata = 5
        }
    }
}
