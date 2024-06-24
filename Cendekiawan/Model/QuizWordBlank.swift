//
//  QuizWordBank.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class QuizWordBlank: Decodable {
    var quizId: Int
    var quizFeedback: Feedback
    var quizDifficultyLevel: Int
    var quizCategory: String
    var quizTitle: String
    var quizAsset: [String]
    var isRedemption: Bool
    var quizPrompt: String
    var quizLetterCount: Int
    var quizLetterChoiceList: [Choice]
    var quizAnswer: String
    
    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool, quizPrompt: String, quizLetterCount: Int, quizLetterChoiceList: [Choice], quizAnswer: String) {
        self.quizId = quizId
        self.quizFeedback = quizFeedback
        self.quizDifficultyLevel = quizDifficultyLevel
        self.quizCategory = quizCategory
        self.quizTitle = quizTitle
        self.quizAsset = quizAsset
        self.isRedemption = isRedemption
        self.quizPrompt = quizPrompt
        self.quizLetterCount = quizLetterCount
        self.quizLetterChoiceList = quizLetterChoiceList
        self.quizAnswer = quizAnswer
    }
}
