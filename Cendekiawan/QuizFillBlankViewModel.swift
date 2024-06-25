//
//  QuizFillBlankViewModel.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 23/06/24.
//

import Foundation

class QuizFillBlankViewModel: ObservableObject {
    @Published var questions: String
    
    @Published var choices: [DraggableChoice] = []
    @Published var droppedAnswer: [Int: DraggableChoice] = [:]
    
    init(questions: String, choices: [Choice]) {
        self.questions = questions
        self.choices = choices.map { DraggableChoice(choiceID: $0.choiceId, choiceText: $0.choiceDescription) }
    }
    
    // here index acts as a key for the hashmap
    func handleChoiceDrop(index: Int, droppedChoice: DraggableChoice) {
        if droppedAnswer[index] != nil {
            handleRemoveChoice(index: index)
        }
        
        // Remove the choice from the choices pool
        if let choiceIndex = choices.firstIndex(where: { $0.choiceId == droppedChoice.choiceId }) {
            choices.remove(at: choiceIndex)
        }
        // Assign the dropped choice to the corresponding index in droppedAnswer
        droppedAnswer[index] = droppedChoice
    }
    
    func handleRemoveChoice(index: Int) {
        // Retrieve the choice from the droppedAnswer dictionary
        if let removedChoice = droppedAnswer.removeValue(forKey: index) {
            // Append the removed choice back to the choices array
            choices.append(removedChoice)
        }
    }
    
}

