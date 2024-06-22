//
//  QuizWordBank.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class QuizWordBlank: Quiz {
    var quizPrompt: String
    var quizLetterCount: Int
    var quizLetterChoiceList: [Choice]
    var quizAnswer: String
    
    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool, quizPrompt: String, quizLetterCount: Int, quizLetterChoiceList: [Choice], quizAnswer: String) {
        self.quizPrompt = quizPrompt
        self.quizLetterCount = quizLetterCount
        self.quizLetterChoiceList = quizLetterChoiceList
        self.quizAnswer = quizAnswer
        
        super.init(quizId: quizId, quizFeedback: quizFeedback, quizDifficultyLevel: quizDifficultyLevel, quizCategory: quizCategory, quizTitle: quizTitle, quizAsset: quizAsset, isRedemption: isRedemption)
    }
}
