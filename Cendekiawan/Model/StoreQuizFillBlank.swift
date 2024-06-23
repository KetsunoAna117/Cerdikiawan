//
//  StoreQuizFillBlank.swift
//  Cendekiawan
//
//  Created by Roland Ramadan on 23/06/24.
//

import Foundation

struct StoreQuizFillBlank: Hashable, Codable {
    var quizId: Int
    var quizFeedback: StoreFeedback
    var quizDifficultyLevel: Int
    var quizCategory: String
    var quizTitle: String
    var isRedemption: Bool
    var quizAsset: [String]
    var quizStory: String
    var quizChoiceList: [StoreChoice]
    var quizAnswerIdList: [Int]
}
