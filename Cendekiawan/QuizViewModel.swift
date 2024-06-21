//
//  QuizViewModel.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation
import Firebase

@Observable
class QuizViewModel {
    var quizRightAnswer: Int = 0
    var quizExperienceGain: Int = 0
    var quizTrophyGain: Trophy = Trophy(value: 0)
    var listQuizQuestion: [StoreQuizData] = load("QuizAll.json")
    
//    init(quizRightAnswer: Int, quizExperienceGain: Int, quizTrophyGain: Trophy) {
//        self.quizRightAnswer = quizRightAnswer
//        self.quizExperienceGain = quizExperienceGain
//        self.quizTrophyGain = quizTrophyGain
//    }
    
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data


    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
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

//class Quiz {
//    var quizId: Int
//    var quizFeedback: Feedback
//    var quizDifficultyLevel: Int
//    var quizCategory: String
//    var quizTitle: String
//    var isRedemption: Bool
//    var quizAsset: [String]
//    
//    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool) {
//        self.quizId = quizId
//        self.quizFeedback = quizFeedback
//        self.quizDifficultyLevel = quizDifficultyLevel
//        self.quizCategory = quizCategory
//        self.quizTitle = quizTitle
//        self.quizAsset = quizAsset
//        self.isRedemption = isRedemption
//    }
//
//}

//class Feedback {
//    var quizID: Int
//    var feedbackDescription: String
//    
//    init(quizID: Int, feedbackDescription: String) {
//        self.quizID = quizID
//        self.feedbackDescription = feedbackDescription
//    }
//}

//class QuizMultiChoice: Quiz {
//    var quizStory: String
//    var quizQuestion: String
//    var quizAnswerID: Int
//    var quizChoiceList: [Choice]
//    
//    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool, quizStory: String, quizQuestion: String, quizAnswerID: Int, quizChoiceList: [Choice]) {
//        
//        self.quizStory = quizStory
//        self.quizQuestion = quizQuestion
//        self.quizAnswerID = quizAnswerID
//        self.quizChoiceList = quizChoiceList
//        
//        super.init(quizId: quizId, quizFeedback: quizFeedback, quizDifficultyLevel: quizDifficultyLevel, quizCategory: quizCategory, quizTitle: quizTitle, quizAsset: quizAsset, isRedemption: isRedemption)
//    }
//}

//class QuizFillBlank: Quiz {
//    var quizStory: String
//    var quizChoiceList: [Choice]
//    var quizAnswerList: [Int]
//    
//    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool, quizStory: String, quizChoiceList: [Choice], quizAnswerList: [Int]) {
//        self.quizStory = quizStory
//        self.quizChoiceList = quizChoiceList
//        self.quizAnswerList = quizAnswerList
//        
//        super.init(quizId: quizId, quizFeedback: quizFeedback, quizDifficultyLevel: quizDifficultyLevel, quizCategory: quizCategory, quizTitle: quizTitle, quizAsset: quizAsset, isRedemption: isRedemption)
//    }
//}

//class QuizWordBlank: Quiz {
//    var quizPrompt: String
//    var quizLetterCount: Int
//    var quizLetterChoiceList: [Choice]
//    var quizAnswer: String
//    
//    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool, quizPrompt: String, quizLetterCount: Int, quizLetterChoiceList: [Choice], quizAnswer: String) {
//        self.quizPrompt = quizPrompt
//        self.quizLetterCount = quizLetterCount
//        self.quizLetterChoiceList = quizLetterChoiceList
//        self.quizAnswer = quizAnswer
//        
//        super.init(quizId: quizId, quizFeedback: quizFeedback, quizDifficultyLevel: quizDifficultyLevel, quizCategory: quizCategory, quizTitle: quizTitle, quizAsset: quizAsset, isRedemption: isRedemption)
//    }
//}

//class QuizConnect: Quiz {
//    var quizPrompt: String
//    var quizLeftChoiceList: [Choice]
//    var quizRightChoiceList: [Choice]
//    var quizAnswerList: [(Int, Int)]
//    
//    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool, quizPrompt: String, quizLeftChoiceList: [Choice], quizRightChoiceList: [Choice], quizAnswerList: [(Int, Int)]) {
//        self.quizPrompt = quizPrompt
//        self.quizLeftChoiceList = quizLeftChoiceList
//        self.quizRightChoiceList = quizRightChoiceList
//        self.quizAnswerList = quizAnswerList
//        
//        super.init(quizId: quizId, quizFeedback: quizFeedback, quizDifficultyLevel: quizDifficultyLevel, quizCategory: quizCategory, quizTitle: quizTitle, quizAsset: quizAsset, isRedemption: isRedemption)
//    }
//}
