//
//  QuizMultiChoice.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class QuizMultiChoice: Quiz {
    var quizStory: String
    var quizQuestion: String
    var quizAnswerID: Int
    var quizChoiceList: [Choice]
    
    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool, quizStory: String, quizQuestion: String, quizAnswerID: Int, quizChoiceList: [Choice]) {
        
        self.quizStory = quizStory
        self.quizQuestion = quizQuestion
        self.quizAnswerID = quizAnswerID
        self.quizChoiceList = quizChoiceList
        
        super.init(quizId: quizId, quizFeedback: quizFeedback, quizDifficultyLevel: quizDifficultyLevel, quizCategory: quizCategory, quizTitle: quizTitle, quizAsset: quizAsset, isRedemption: isRedemption)
    }
}
