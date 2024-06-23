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
    
    @Published var droppedAnswer: [DraggableChoice] = []
    @Published var trunc: [String] = []
    
    init(questions: String, choices: [Choice]) {
        self.questions = questions
        self.choices = choices.map { DraggableChoice(choiceID: $0.choiceID, choiceText: $0.choiceText) }
        self.trunc = questions.split(separator: "__________").map { String($0) }
    }
    
    func setupQuestion(){
        if droppedAnswer.isEmpty {
            droppedAnswer = Array(repeating: DraggableChoice(choiceID: -1, choiceText: ""), count: trunc.count - 1)
        }
    }
    
    func handleChoiceDrop(index: Int, droppedChoice: [DraggableChoice]) {
        let previouslySelectedChoice = droppedAnswer[index]
        droppedAnswer[index] = droppedChoice[0]
        choices.removeAll { $0.uniqueId == droppedChoice[0].uniqueId }
        
        if previouslySelectedChoice.choiceID != -1 {
            print(previouslySelectedChoice.choiceID)
            choices.append(previouslySelectedChoice)
        }
    }
    
    func removeChoicesFromAnswer(index: Int){
        // remove choices
        if droppedAnswer[index].choiceID != -1 {
            choices.append(droppedAnswer[index])
            droppedAnswer[index] = DraggableChoice(choiceID: -1, choiceText: "")
        }
    }
}

