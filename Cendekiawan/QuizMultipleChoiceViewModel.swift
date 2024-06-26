//
//  QuizMultipleChoiceViewModel.swift
//  Cendekiawan
//
//  Created by Roland Ramadan on 25/06/24.
//

import Foundation
import SwiftUI

// TODO: tar di hapus kalo dah mo finalize
class QuizMultipleChoiceViewModel: ObservableObject {
    @Published var quizMultiChoice: QuizMultiChoice
    @Published var selectedAnswerChoiceId: Int = -1
    @Published var isChecked: Bool = false
    
    init(model: QuizMultiChoice) {
        quizMultiChoice = model
    }
    
    func checkBoxColor(choice: Choice) -> Color {
        if isChecked {
            // true false mode
            if quizMultiChoice.quizAnswerId == choice.choiceId {
                return Color.cerdikiawanGreenTua
            } else if selectedAnswerChoiceId == choice.choiceId && choice.choiceId != quizMultiChoice.quizAnswerId {
                return Color.cerdikiawanRed
            } else {
                return Color.cerdikiawanWhite
            }
        } else {
            // select unselect mode
            if selectedAnswerChoiceId == choice.choiceId {
                return Color.cerdikiawanYellow
            } else {
                return Color.cerdikiawanWhite
            }
        }
    }
    
    func checkAnswer() -> Bool {
        if quizMultiChoice.quizAnswerId == selectedAnswerChoiceId {
            return true
        } else {
            return false
        }
    }
}
 
