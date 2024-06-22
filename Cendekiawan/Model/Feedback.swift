//
//  Feedback.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation

class Feedback {
    var quizID: Int
    var feedbackDescription: String
    
    init(quizID: Int, feedbackDescription: String) {
        self.quizID = quizID
        self.feedbackDescription = feedbackDescription
    }
}
