//
//  QuizViewModel.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation
import Firebase

class QuizViewModel: ObservableObject {
    var quizRightAnswer: Int
    var quizExperienceGain: Int
    var quizTrophyGain: Trophy
    @Published var listQuizQuestion: [Quiz]
    
    init(quizRightAnswer: Int, quizExperienceGain: Int, quizTrophyGain: Trophy, listQuizQuestion: [Quiz]) {
        self.quizRightAnswer = quizRightAnswer
        self.quizExperienceGain = quizExperienceGain
        self.quizTrophyGain = quizTrophyGain
        self.listQuizQuestion = listQuizQuestion
    }
    
    //firebase function (not ready yet)
//    func getQuestion() {
//        let db = Firestore.firestore()
//        let ref = db.collection("MultiChoiceQuiz")
//        ref.getDocuments { snapshot, error in
//            guard error == nil else {
//                print(error!.localizedDescription)
//                return
//            }
//
//            if let snapshot = snapshot {
//                for document in snapshot.documents {
//                    let data = document.data()
//
//                    let isRedemption = data["isRedemption"] as? Bool ?? false
//                    let quizAnswerId = data["quizAnswerId"] as? Int ?? 0 //blm
//                    let quizAsset = data["quizAsset"] as? [String] ?? [""]
//                    let quizCategory = data["quizCategory"] as? String ?? ""
//                    let quizChoiceList = data["quizChoiceList"] as? [String] ?? [""] //blm
//                    let quizDifficultyLevel = data["quizDifficultyLevel"] as? Int ?? 0
//                    let quizId = data["quizId"] as? Int ?? 0
//                    let quizQuestion = data["quizQuestion"] as? String ?? "" //blm
//                    let quizStory = data["quizStory"] as? String ?? ""//blm
//                    let quizTitle = data["quizTitle"] as? String ?? ""
//                    let quizFeedback = data["quizFeedback"] as? String ?? "" //blm betul
//
//                    let quiz = Quiz(quizId: quizId, quizFeedback: <#T##Feedback#>, quizDifficultyLevel: quizDifficultyLevel, quizCategory: quizCategory, quizTitle: quizTitle, quizAsset: quizAsset, isRedemption: isRedemption)
//                    self.listQuizQuestion.append(quiz)
//                }
//            }
//        }
//    }
    
}
