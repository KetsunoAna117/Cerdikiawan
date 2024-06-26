//
//  QuizWordBlankViewModel.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 23/06/24.
//

import Foundation
import SwiftUI

class QuizWordBlankViewModel: ObservableObject {
    @Published var guessedWord: [Choice] = []
    @Published var nextInputFlag = 0
    @Published var quizWordBlank: QuizWordBlank?
    @Published var isChecked: Bool = false
    
    func checkFilled() -> Bool {
        for i in 0..<guessedWord.count {
            if guessedWord[i].choiceDescription == "" {
                return false
            }
        }
        return true
    }
    
    //func to run the dummydata comparing the answer with the guessWord
    func checkAnswer() -> Bool{
        if let correctString = quizWordBlank?.quizAnswer{
            for i in 0..<guessedWord.count-1 {
                if guessedWord[i].choiceDescription != String(correctString[correctString.index(correctString.startIndex, offsetBy: i)]) {
                    return false
                }
            }
        }else {
            return false
        }
        return true
    }
    
    init(model: QuizWordBlank) {
        quizWordBlank = model
    }
    
    func checkBoxColor(state: String, choice: Choice) -> Color {
        if state == "Selected" {
            if isChecked {
                if let index = guessedWord.firstIndex(where: { $0.choiceId == choice.choiceId }),
                   let quizAnswer = quizWordBlank?.quizAnswer {
                    let stringIndex = quizAnswer.index(quizAnswer.startIndex, offsetBy: index)
                    let correctChar = quizAnswer[stringIndex]
                    
                    if guessedWord[index].choiceDescription == String(correctChar) {
                        //true
                        return Color.cerdikiawanGreenTua
                    } else {
                        //false
                        return Color.cerdikiawanRed
                    }
                    
                }
                return Color.cerdikiawanWhite
            } else{
                // unchecked, selected or unselected
                return Color.cerdikiawanOrange
            }
        } else {
            return Color.cerdikiawanWhite
        }
    }
    
    func setupQuestion(){
        if guessedWord.isEmpty {
            guessedWord = Array(repeating: Choice(choiceId: -1, choiceDescription: ""), count: quizWordBlank?.quizLetterCount ?? 0)
        }
    }
    
    func checkNextEmptyIndex(substring: [Choice]) -> Int {
        var nextInputFlag = 0
        if let nextIndex = substring.firstIndex(where: { $0.choiceId == -1 }) {
            nextInputFlag = nextIndex
        } else {
            nextInputFlag = substring.count
        }
        return nextInputFlag
    }
    
    func removeCharacterFromAnswer(index: Int){
        if guessedWord[index].choiceId != -1 {
            quizWordBlank?.quizLetterChoiceList.append(guessedWord[index])
            guessedWord[index] = Choice(choiceId: -1, choiceDescription: "")
            nextInputFlag = checkNextEmptyIndex(substring: guessedWord)
        }
    }
    
    func addCharacterToAnswer(choosed: Choice){
        if nextInputFlag < guessedWord.count {
            quizWordBlank?.quizLetterChoiceList.removeAll { $0.choiceId == choosed.choiceId }
            guessedWord[nextInputFlag] = choosed
            nextInputFlag =  checkNextEmptyIndex(substring: guessedWord)
        }
    }
}
