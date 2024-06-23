//
//  StoreWordBlank.swift
//  Cendekiawan
//
//  Created by Roland Ramadan on 23/06/24.
//

import Foundation

struct StoreWordBlank: Codable, Hashable{
    var quizId: Int
    var quizFeedback: StoreFeedback
    var quizDifficultyLevel: Int
    var quizCategory: String
    var quizTitle: String
    var quizAsset: [String]
    var isRedemption: Bool
    var quizPrompt: String
    var quizLetterCount: Int
    var quizLetterChoiceList: [StoreChoice]
    var quizAnswer: String
}
