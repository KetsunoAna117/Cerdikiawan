//
//  StoreConnect.swift
//  Cendekiawan
//
//  Created by Roland Ramadan on 23/06/24.
//

import Foundation

struct StoreQuizConnect: Codable, Hashable{
    var quizId: Int
    var quizFeedback: StoreFeedback
    var quizDifficultyLevel: Int
    var quizCategory: String
    var quizTitle: String
    var quizAsset: [String]
    var isRedemption: Bool
    var quizPrompt: String
    var quizLeftChoiceList: [StoreChoice]
    var quizRightChoiceList: [StoreChoice]
}
