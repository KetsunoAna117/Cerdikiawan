//
//  QuizConnect.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class QuizConnect: Decodable {
    var quizId: Int
    var quizFeedback: Feedback
    var quizDifficultyLevel: Int
    var quizCategory: String
    var quizTitle: String
    var quizAsset: [String]
    var isRedemption: Bool
    var quizPrompt: String
    var quizLeftChoiceList: [Choice]
    var quizRightChoiceList: [Choice]
    
    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool, quizPrompt: String, quizLeftChoiceList: [Choice], quizRightChoiceList: [Choice]) {
        self.quizId = quizId
        self.quizFeedback = quizFeedback
        self.quizDifficultyLevel = quizDifficultyLevel
        self.quizCategory = quizCategory
        self.quizTitle = quizTitle
        self.quizAsset = quizAsset
        self.isRedemption = isRedemption
        self.quizPrompt = quizPrompt
        self.quizLeftChoiceList = quizLeftChoiceList
        self.quizRightChoiceList = quizRightChoiceList
    }
}
