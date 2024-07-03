//
//  QuizFillBlankViewModel.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 23/06/24.
//

import Foundation

class QuizFillBlankViewModel: ObservableObject {
    @Published var choicesPool: [DraggableChoice] = []
    @Published var droppedAnswer: [Int: DraggableChoice] = [:]
    @Published var model: QuizFillBlank
    @Published var isFieldFilled: Bool
    @Published var choicesCount: Int
    @Published var listCorrectAnswerId: [Int]
    @Published var listWrongAnswerId: [Int]
    @Published var checkAnswerEvent: Bool
    
    init(quizFillBlankModel: QuizFillBlank) {
        self.model = quizFillBlankModel
        self.choicesPool = quizFillBlankModel.quizChoiceList.map { DraggableChoice(choiceID: $0.choiceId, choiceText: $0.choiceDescription) }
        
        self.isFieldFilled = false
        self.choicesCount = quizFillBlankModel.quizChoiceList.count
        
        self.listCorrectAnswerId = []
        self.listWrongAnswerId = []
        self.checkAnswerEvent = false
    }
    
    // here index acts as a key for the hashmap
    func handleChoiceDrop(index: Int, droppedChoice: DraggableChoice) {
        // Remove any existing entry in droppedAnswer that matches the droppedChoice
        if let flag = isAlreadyInAnswer(droppedChoice: droppedChoice){
            droppedAnswer.removeValue(forKey: flag)
        }
        
        // if there's existing droppedAnswer at location, replace it
        if droppedAnswer[index] != nil {
            handleRemoveChoice(index: index)
        }
        
        // Remove the choice from the choices pool
        if let choiceIndex = choicesPool.firstIndex(where: { $0.choiceId == droppedChoice.choiceId }) {
            choicesPool.remove(at: choiceIndex)
        }
    
        // Assign the dropped choice to the corresponding index in droppedAnswer
        droppedAnswer[index] = droppedChoice
        
        // update is All Field Filled status
        if droppedAnswer.count >= choicesCount {
            isFieldFilled = true
        }
        else {
            isFieldFilled = false
        }
    }
    
    func handleChoiceTap(droppedChoice: DraggableChoice) {
        for i in 0...choicesCount {
            if droppedAnswer[i] == nil {
                handleChoiceDrop(index: i, droppedChoice: droppedChoice)
                return
            }
        }
    }
    
    func handleRemoveChoice(index: Int) {
        // Retrieve the choice from the droppedAnswer dictionary
        if let removedChoice = droppedAnswer.removeValue(forKey: index) {
            // Append the removed choice back to the choices array
            choicesPool.append(removedChoice)
            isFieldFilled = false
        }
    }
    
    func isAlreadyInAnswer(droppedChoice: DraggableChoice) -> Int?{
        for (key, value) in droppedAnswer {
            if value.choiceId == droppedChoice.choiceId {
                return key
            }
        }
        return nil
    }
    
    func checkAnswer(){
        checkAnswerEvent = true
        for i in 0...choicesCount {
            if let answer = droppedAnswer[i] {
                let answerKeyId = model.quizAnswerIdList[i]
                // if answerId is the same with answerKeyId push index into lisCorrectAnswerId
                if answer.choiceId == answerKeyId {
                    listCorrectAnswerId.append(i) // i used index because droppableBox saved the index, not choiceId
                }
                // else if incorrect, push index into listWrongAnswerId
                else {
                    listWrongAnswerId.append(i)
                }
            }
        }
    }
    
//    // here index acts as a key for the hashmap
//     func handleChoiceDrop(index: Int, droppedChoice: DraggableChoice) {
//         // Remove any existing entry in droppedAnswer that matches the droppedChoice
//         if let existingIndex = isAlreadyInAnswer(droppedChoice: droppedChoice) {
//             droppedAnswer.removeValue(forKey: existingIndex)
//         }
//         
//         // Check if there's an existing choice at the index
//         if let existingChoice = droppedAnswer[index] {
//             // Swap the existing choice with the new dropped choice
//             droppedAnswer[index] = droppedChoice
//             // Return the existing choice back to the choices pool
//             if let choiceIndex = choices.firstIndex(where: { $0.choiceId == existingChoice.choiceId }) {
//                 choices[choiceIndex] = existingChoice
//             } else {
//                 choices.append(existingChoice)
//             }
//         } else {
//             // Remove the choice from the choices pool
//             if let choiceIndex = choices.firstIndex(where: { $0.choiceId == droppedChoice.choiceId }) {
//                 choices.remove(at: choiceIndex)
//             }
//             // Assign the dropped choice to the corresponding index in droppedAnswer
//             droppedAnswer[index] = droppedChoice
//         }
//         
//         // Update is All Field Filled status
//         isFieldFilled = droppedAnswer.count >= choicesCount
//     }
    
}

