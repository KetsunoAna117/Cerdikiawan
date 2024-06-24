//
//  QuizMultiChoice.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class QuizMultiChoice: Codable {
    var quizId: Int
    var quizFeedback: Feedback
    var quizDifficultyLevel: Int
    var quizCategory: String
    var quizTitle: String
    var isRedemption: Bool
    var quizAsset: [String]
    var quizStory: String
    var quizQuestion: String
    var quizChoiceList: [Choice]
    var quizAnswerId: Int
    
    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, isRedemption: Bool, quizAsset: [String], quizStory: String, quizQuestion: String, quizChoiceList: [Choice], quizAnswerId: Int) {
        self.quizId = quizId
        self.quizFeedback = quizFeedback
        self.quizDifficultyLevel = quizDifficultyLevel
        self.quizCategory = quizCategory
        self.quizTitle = quizTitle
        self.isRedemption = isRedemption
        self.quizAsset = quizAsset
        self.quizStory = quizStory
        self.quizQuestion = quizQuestion
        self.quizChoiceList = quizChoiceList
        self.quizAnswerId = quizAnswerId
    }
}
