//
//  QuizViewModel.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation
import SwiftUI

class QuizViewModel {
    @StateObject var db: DatabaseHelper = DatabaseHelper.shared
    var quizRightAnswer: Int
    var quizExperienceGain: Int
    var quizTrophyGain: Trophy
    var listQuizQuestion: [Quiz]
    
    init(quizRightAnswer: Int, quizExperienceGain: Int, quizTrophyGain: Trophy, listQuizQuestion: [Quiz]) {
        self.quizRightAnswer = quizRightAnswer
        self.quizExperienceGain = quizExperienceGain
        self.quizTrophyGain = quizTrophyGain
        self.listQuizQuestion = listQuizQuestion
    }
    
    func getQuestionFromDatabase() -> Quiz {
        return listQuizQuestion[1]
    }
    
    func updateQuestionRight() {
        
    }
    
    func pushQuestionWrongToTail() {
        
    }
    
    func getNextQuestion() {
        
    }
    
}
