//
//  QuizViewModel.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation
import SwiftUI

class QuizViewModel: ObservableObject {
    
    @Published var quizExperienceGain: Int = 0
    @Published var nextQuiz: (quizModel: String, tipeQuiz: String)
    @Published var valueProgressBar: Int = 0
    @StateObject var user: User = User(name: "User1")
    @Published var redemptionIdList: [Int]?
    @Published var currentQuiz: Int?
    @Published var quizIdePokok: [Int] = []
    @Published var quizImplisit: [Int] = []
    
    var modelData = QuizModelData()
    
    init(nextQuiz: (quizModel: String, tipeQuiz: String)) {
        self.nextQuiz = nextQuiz
    }
    
    func startGameplay() {
        let storeRandomizedQuiz: (String, String) = getRandomizedProficiency(ProficiencyLevelStorage(idePokok: user.proficiencyLevelIdePokok, kosakata: user.proficiencyLevelKosakata, implisit: user.proficiencyLevelImplisit))
        let (quizModel, tipeQuiz) = storeRandomizedQuiz
        
        nextQuiz = (quizModel, tipeQuiz)
        
        switch nextQuiz.tipeQuiz {
        case "kosakata":
            switch nextQuiz.quizModel {
            case "FillBlank":
                currentQuiz = modelData.getRumpang(difficulty: user.difficultyLevel)!.randomElement()?.quizId
            case "WordBlank":
                currentQuiz = modelData.getWordle(difficulty: user.difficultyLevel)!.randomElement()?.quizId
            default:
                currentQuiz = modelData.getSambung(difficulty: user.difficultyLevel)!.randomElement()?.quizId
            }
            
        default:
            switch nextQuiz.quizModel{
            case "idePokok":
                let ranges = [
                    Array(1...3),
                    Array(11...13),
                    Array(21...23)
                ]
                
                currentQuiz = modelData.getIdePokok(difficulty: user.difficultyLevel)!.randomElement()?.quizId
                
            case "implisit":
                let ranges = [
                    Array(4...7),
                    Array(14...17),
                    Array(24...27)
                ]
                
                currentQuiz = modelData.getimplisit(difficulty: user.difficultyLevel)!.randomElement()?.quizId
                
            default:
                let ranges = [
                    Array(4...7),
                    Array(14...17),
                    Array(24...27)
                ]
                
                currentQuiz = modelData.getimplisit(difficulty: user.difficultyLevel)!.randomElement()?.quizId
            }
        }
        updateValueProgressBar()
    }
    
    func getQuizFromId <T>(id: Int) -> T{
        var quiz: T
        switch id{
        case 1...3, 11...13, 21...23:
            quiz = modelData.getIdePokok(difficulty: user.difficultyLevel)![(id-1)%2] as! T
        case 4...7, 14...17, 24...27:
            quiz = modelData.getimplisit(difficulty: user.difficultyLevel)![(id-1)%3] as! T
        case 8, 18, 28:
            quiz = modelData.getRumpang(difficulty: user.difficultyLevel)![0] as! T
        case 9, 19, 29:
            quiz = modelData.getWordle(difficulty: user.difficultyLevel)![0] as! T
        case 10, 20, 30:
            quiz = modelData.getSambung(difficulty: user.difficultyLevel)![0] as! T
        default:
            return modelData.getSambung(difficulty: user.difficultyLevel)![0] as! T
        }
        
        return quiz
    }
    
    func updateValueProgressBar() {
        if valueProgressBar >= 10 {
            valueProgressBar = 10
        } else {
            valueProgressBar += 1
        }
    }
    
    func checkAndRemoveRanges(ranges: [[Int]]) {
        for range in ranges {
            if containsRange(range: range, in: quizIdePokok) {
                removeRange(range: range, from: &quizIdePokok)
                break
            }
        }
    }
    
    // Check if all elements in the range are present in the list
    func containsRange(range: [Int], in list: [Int]) -> Bool {
        return Set(range).isSubset(of: Set(list))
    }
    
    // Remove all elements in the range from the list
    func removeRange(range: [Int], from list: inout [Int]) {
        list.removeAll(where: { range.contains($0) })
    }
    
    func updateIdePokokProeficiency(win: Bool){
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
        checkLevel()
    }

    func updateImplisitProeficiency(win: Bool){
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
        checkLevel()
    }

    func updateKosakataProeficiency(win: Bool){
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
        checkLevel()
    }

    func checkLevel(){
        
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
    
}

