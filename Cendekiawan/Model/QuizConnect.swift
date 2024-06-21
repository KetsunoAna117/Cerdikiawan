//
//  QuizConnect.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class QuizConnect: Quiz {
    var quizPrompt: String
    var quizLeftChoiceList: [Choice]
    var quizRightChoiceList: [Choice]
    
    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool, quizPrompt: String, quizLeftChoiceList: [Choice], quizRightChoiceList: [Choice]) {
        self.quizPrompt = quizPrompt
        self.quizLeftChoiceList = quizLeftChoiceList
        self.quizRightChoiceList = quizRightChoiceList
        
        super.init(quizId: quizId, quizFeedback: quizFeedback, quizDifficultyLevel: quizDifficultyLevel, quizCategory: quizCategory, quizTitle: quizTitle, quizAsset: quizAsset, isRedemption: isRedemption)
    }
}
