//
//  QuizFillBlankViewModel.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 23/06/24.
//

import Foundation

class QuizFillBlankViewModel: ObservableObject {
    @Published var questions: String
    @Published var choices: [Choice] = []
    
    // Dictionary to track placed choices
    @Published var placedChoices: [Int: Choice] = [:]
    
    init(questions: String, choices: [Choice]) {
        self.questions = questions
        self.choices = choices.map { DraggableChoice(choiceID: $0.choiceId, choiceText: $0.choiceDescription) }
    }
    
  
}

