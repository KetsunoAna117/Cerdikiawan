//
//  QuizFillBlank.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class QuizFillBlank: Quiz {
    var quizStory: String
    var quizChoiceList: [Choice]
    var quizAnswerList: [Int]
    
    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool, quizStory: String, quizChoiceList: [Choice], quizAnswerList: [Int]) {
        self.quizStory = quizStory
        self.quizChoiceList = quizChoiceList
        self.quizAnswerList = quizAnswerList
        
        super.init(quizId: quizId, quizFeedback: quizFeedback, quizDifficultyLevel: quizDifficultyLevel, quizCategory: quizCategory, quizTitle: quizTitle, quizAsset: quizAsset, isRedemption: isRedemption)
    }
}
