//
//  Qiz.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class Quiz: Identifiable {
    var quizId: Int
    var quizFeedback: Feedback
    var quizDifficultyLevel: Int
    var quizCategory: String
    var quizTitle: String
    var quizAsset: [String]
    var isRedemption: Bool
    
    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool) {
        self.quizId = quizId
        self.quizFeedback = quizFeedback
        self.quizDifficultyLevel = quizDifficultyLevel
        self.quizCategory = quizCategory
        self.quizTitle = quizTitle
        self.quizAsset = quizAsset
        self.isRedemption = isRedemption
    }

}
