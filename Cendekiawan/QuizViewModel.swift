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
    @Published var nextQuiz: (quizModel: String, tipeQuiz: String) //quizModel itu "MultiChoice", "FillBlank", "WordBlank", "Connect"
                                                                   //tipeQuiz itu "idePokok", "implisit", "kosakata"
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
    
    //fungsi untuk masuk ke main quiz dari homeview ke quizview untuk pertama kalinya (jalan sekali doank saat aplikasi jalan)
    func startGameplay() {
        var storeRandomizedQuiz: (String, String)
        let options = ["FillBlank", "Connect", "WordBlank"]
        
        repeat {
            storeRandomizedQuiz = getRandomizedProficiency(ProficiencyLevelStorage( //ini fungsi buat get randomsoal
                idePokok: user.proficiencyLevelIdePokok,
                kosakata: user.proficiencyLevelKosakata,
                implisit: user.proficiencyLevelImplisit
            ))
            
            let (quizModel, tipeQuiz) = storeRandomizedQuiz
            
            nextQuiz = (quizModel, tipeQuiz)
            
        } while (options.contains(nextQuiz.quizModel) && storedQuizModel == nextQuiz.quizModel) //ini buat bikin biar kalo soalnya adalah fillblank, connect-
                                                                                                //atau wordblank, nanti dia bakal mastiin habis wordblank gak bakal-
                                                                                                //wordblank lagi(kalo soalnya banyak, bisa dicounter pake cara dibawah
                                                                                                //ini)
        //ini buat counter bagaimana cara get random id yang tidak akan mengulang kembali sblm soalnya dipakai semuanya
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
                currentQuiz = modelData.getIdePokok(difficulty: user.difficultyLevel)!.randomElement()?.quizId
                while quizIdePokok.contains(currentQuiz!){
                    //disini check buat mastiin bahwa jika id dari quiz sudah ada semua sesuai user diffulty dan profisiensi, maka harus reset
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
                
            default:
                currentQuiz = modelData.getimplisit(difficulty: user.difficultyLevel)!.randomElement()?.quizId
                while quizImplisit.contains(currentQuiz!){
                    //disini check buat mastiin bahwa jika id dari quiz sudah ada semua sesuai user diffulty dan profisiensi, maka harus reset
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
            }
        }
    }
    
    //fungsi untuk start main quiz seterusnya di setiap view saat/setelah main
    func startGameplay(correct: Bool) {
        if valueProgressBar < 10 {
            if correct {
                switch currentQuiz! { //ini buat add exp ke user default & nampung quizExperienceGain untuk QuizResultView
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
            }
            
            UpdateUserDefaultProficiency(correct)
            updateValueProgressBar()
            
            if !correct{ //jika jawaban salah, nambahin ke redemption list
                redemptionIdList.append(currentQuiz!)
            }
            
            if valueProgressBar < 10 { //ini khusus buat handle soal ke 10, karena kalo engga, redemption ga jalan, ya ngebug sih
                startGameplay()
            } else {
                startRedemption(correct: correct, QuesNo10: true)
            }
        }
        else{
            startRedemption(correct: correct, QuesNo10: false)// jalanin redemption jalur normal stlh lewat soal no 10
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
    
    //buat get quiz id untuk secara otomatis udh di bagi berdasarkan kelas yang sesuai dengan user difficulty dan profisiensi user, dimana-
    //fungsi randomizernya udh jalan sblmnya pas startGameplay
    func getQuizFromId <T>(id: Int) -> T{
        var quiz: T
        switch id { //ini id soal json nya
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
    
    //buat update progressbar yang di quizview
    func updateValueProgressBar() {
        if valueProgressBar >= 10 {
            valueProgressBar = 10
        } else {
            valueProgressBar += 1
        }
    }
    
    //function untuk update proficiency kalau benar/salah jawab soal ke user default
    func UpdateUserDefaultProficiency(_ correct: Bool) {
        switch nextQuiz.tipeQuiz {
        case "kosakata":
            updateKosakataProeficiency(win: correct)
        case "idePokok":
            updateIdePokokProeficiency(win: correct)
        default:
            updateImplisitProeficiency(win: correct)
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
    
    //ini buat check untuk user nya naik kelas atau turun kelas (4, 5, 6)
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

