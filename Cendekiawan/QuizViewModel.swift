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
    @Published var user: User = User(name: "Test")
    @Published var redemptionIdList: [Int] = []
    @Published var currentQuiz: Int?
    @Published var quizIdePokok: [Int] = []
    @Published var quizImplisit: [Int] = []
    @Published var storedQuizModel: String = ""
    
    var modelData = QuizModelData()
    
    init(nextQuiz: (quizModel: String, tipeQuiz: String)) {
        self.nextQuiz = nextQuiz
    }
    
    func startGameplay() {
        var storeRandomizedQuiz: (String, String)
        let options = ["FillBlank", "Connect", "WordBlank"]
        
        repeat {
            storeRandomizedQuiz = getRandomizedProficiency(ProficiencyLevelStorage(
                idePokok: user.proficiencyLevelIdePokok,
                kosakata: user.proficiencyLevelKosakata,
                implisit: user.proficiencyLevelImplisit
            ))
            
            let (quizModel, tipeQuiz) = storeRandomizedQuiz
            
            nextQuiz = (quizModel, tipeQuiz)
            
        } while (options.contains(nextQuiz.quizModel) && storedQuizModel == nextQuiz.quizModel)
        
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
            switch nextQuiz.tipeQuiz{
            case "idePokok":
                print("MASUK default multichoice idepokok")
                
                currentQuiz = modelData.getIdePokok(difficulty: user.difficultyLevel)!.randomElement()?.quizId
                while quizIdePokok.contains(currentQuiz!){

                    if ((quizIdePokok.contains(1)) && (quizIdePokok.contains(2)) && (quizIdePokok.contains(3))) ||
                        ((quizIdePokok.contains(11)) && (quizIdePokok.contains(12)) && (quizIdePokok.contains(13))) ||
                        ((quizIdePokok.contains(21)) && (quizIdePokok.contains(22)) && (quizIdePokok.contains(23))) {
                        let temp = quizIdePokok.last
                        
                        quizIdePokok.removeAll()
                        
                        while currentQuiz == temp {
                            currentQuiz = modelData.getIdePokok(difficulty: user.difficultyLevel)!.randomElement()?.quizId
                        }
                    } else {
                        currentQuiz = modelData.getIdePokok(difficulty: user.difficultyLevel)!.randomElement()?.quizId
                    }
                }
                quizIdePokok.append(currentQuiz!)
                print("idePokok: \(quizIdePokok)")
                
            default:
                print("MASUK default multichoice implisit")
                
                currentQuiz = modelData.getimplisit(difficulty: user.difficultyLevel)!.randomElement()?.quizId
                while quizImplisit.contains(currentQuiz!){
                    
                    if ((quizImplisit.contains(4)) && (quizImplisit.contains(5)) && (quizImplisit.contains(6)) && (quizImplisit.contains(7))) ||
                        ((quizImplisit.contains(14)) && (quizImplisit.contains(15)) && (quizImplisit.contains(16)) && (quizImplisit.contains(17)))  ||
                        ((quizImplisit.contains(24)) && (quizImplisit.contains(25)) && (quizImplisit.contains(26)) && (quizImplisit.contains(27))) {
                        let temp = quizImplisit.last
                        
                        quizImplisit.removeAll()
                        
                        while currentQuiz == temp {
                            currentQuiz = modelData.getimplisit(difficulty: user.difficultyLevel)!.randomElement()?.quizId
                        }
                    } else {
                        currentQuiz = modelData.getimplisit(difficulty: user.difficultyLevel)!.randomElement()?.quizId
                    }

                }
                quizImplisit.append(currentQuiz!)
                print("implisit: \(quizImplisit)")
            }
        }
    }
    
    func startGameplay(correct: Bool) {
        
        if valueProgressBar < 10 {
            if correct {
                switch currentQuiz! {
                case 1...10:
                    user.exp += 1
                    quizExperienceGain += 1
                    print("exp nambah, \(user.exp)")
                case 11...20:
                    user.exp += 5
                    quizExperienceGain += 5
                    print("exp nambah, \(user.exp)")
                default:
                    user.exp += 10
                    quizExperienceGain += 10
                    print("exp nambah, \(user.exp)")
                }
                
                switch nextQuiz.tipeQuiz {
                case "kosakata":
                    updateKosakataProeficiency(win: correct)
                case "idePokok":
                    updateIdePokokProeficiency(win: correct)
                default:
                    updateImplisitProeficiency(win: correct)
                }
                
//                print("\(nextQuiz.quizModel), \(nextQuiz.tipeQuiz)")
//                print("idePokok: \(user.proficiencyLevelIdePokok)")
//                print("kosakata: \(user.proficiencyLevelKosakata)")
//                print("implisit: \(user.proficiencyLevelImplisit)")
//                print("kelas: \(user.difficultyLevel)")
            } else {
                switch nextQuiz.tipeQuiz {
                case "kosakata":
                    updateKosakataProeficiency(win: correct)
                case "idePokok":
                    updateIdePokokProeficiency(win: correct)
                default:
                    updateImplisitProeficiency(win: correct)
                }
                
//                print("\(nextQuiz.quizModel), \(nextQuiz.tipeQuiz)")
//                print("idePokok: \(user.proficiencyLevelIdePokok)")
//                print("kosakata: \(user.proficiencyLevelKosakata)")
//                print("implisit: \(user.proficiencyLevelImplisit)")
//                print("kelas: \(user.difficultyLevel)")
            }
            
            updateValueProgressBar()
            if !correct{
                redemptionIdList.append(currentQuiz!)
            }
            
            if valueProgressBar < 10 {
                startGameplay()
            } else {
                startRedemption(correct: correct, QuesNo10: true)
            }
        }
        else{
            startRedemption(correct: correct, QuesNo10: false)
        }
    }
    
    func startRedemption(correct: Bool, QuesNo10: Bool) {
        if !redemptionIdList.isEmpty{
            currentQuiz = redemptionIdList.first
            switch currentQuiz!{
            case 1...3, 11...13, 21...23:
                nextQuiz = ("MultiChoice", "idePokok")
            case 4...7, 14...17, 24...27:
                nextQuiz = ("MultiChoice", "implisit")
            case 8, 18, 28:
                nextQuiz = ("FillBlank", "kosakata")
            case 9, 19, 29:
                nextQuiz = ("WordBlank", "kosakata")
            case 10, 20, 30:
                nextQuiz = ("Connect", "kosakata")
            default:
                nextQuiz = ("MultiChoice", "idePokok")
            }
            if !QuesNo10 {
                if !correct{
                    redemptionIdList.append(currentQuiz!)
                }
                redemptionIdList.removeFirst()
            }
        }
    }
    
    func getQuizFromId <T>(id: Int) -> T{
        var quiz: T
        switch id {
        case 1...3:
            quiz = modelData.getIdePokok(difficulty: user.difficultyLevel)![id-1] as! T
        case 11...13:
            quiz = modelData.getIdePokok(difficulty: user.difficultyLevel)![id-11] as! T
        case 21...23:
            quiz = modelData.getIdePokok(difficulty: user.difficultyLevel)![id-21] as! T
        case 4...7:
            quiz = modelData.getimplisit(difficulty: user.difficultyLevel)![id-4] as! T
        case 14...17:
            quiz = modelData.getimplisit(difficulty: user.difficultyLevel)![id-14] as! T
        case 24...27:
            quiz = modelData.getimplisit(difficulty: user.difficultyLevel)![id-24] as! T
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

