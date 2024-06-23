//
//  QuizFillBlank.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class QuizFillBlank: Quiz{
    var quizStory: String
    var quizChoiceList: [Choice]
    var quizAnswerList: [Int]
    
    init(quizId: Int, quizFeedback: Feedback, quizDifficultyLevel: Int, quizCategory: String, quizTitle: String, quizAsset: [String], isRedemption: Bool, quizStory: String, quizChoiceList: [Choice], quizAnswerList: [Int]) {
        self.quizStory = quizStory
        self.quizChoiceList = quizChoiceList
        self.quizAnswerList = quizAnswerList
        
        super.init(quizId: quizId, quizFeedback: quizFeedback, quizDifficultyLevel: quizDifficultyLevel, quizCategory: quizCategory, quizTitle: quizTitle, quizAsset: quizAsset, isRedemption: isRedemption)
    }
    
// ok to delete
    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        quizStory = try container.decode(String.self, forKey: .quizStory)
//        quizChoiceList = try container.decode([Choice].self, forKey: .quizChoiceList)
//        quizAnswerList = try container.decode([Int].self, forKey: .quizAnswerList)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(quizStory, forKey: .quizStory)
//        try container.encode(quizChoiceList, forKey: .quizChoiceList)
//        try container.encode(quizAnswerList, forKey: .quizAnswerList)
//    }
//    
//    private enum CodingKeys: String, CodingKey {
//        case quizStory, quizChoiceList, quizAnswerList
//    }
}
