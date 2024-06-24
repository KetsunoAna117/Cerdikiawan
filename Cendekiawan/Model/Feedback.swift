//
//  Feedback.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class Feedback: Codable {
    var quizId: Int
    var feedbackDescription: String

    init(quizId: Int, feedbackDescription: String) {
        self.quizId = quizId
        self.feedbackDescription = feedbackDescription
    }
}
