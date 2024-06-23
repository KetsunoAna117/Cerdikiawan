//
//  StoreQuizData.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 20/06/24.
//

import Foundation
import SwiftUI

struct StoreQuizData: Hashable, Codable {
    var quizId: Int
    var quizFeedback: StoreFeedback
    var quizDifficultyLevel: Int
    var quizCategory: String
    var quizTitle: String
    var isRedemption: Bool
    var quizAsset: [String]
    var quizStory: String
    var quizQuestion: String
    var quizChoiceList: [StoreChoice]
    var quizAnswerId: Int
}
