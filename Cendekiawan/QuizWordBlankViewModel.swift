//
//  QuizWordBlankViewModel.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 23/06/24.
//

import Foundation

class QuizWordBlankViewModel: ObservableObject {
    @Published var choices: [Choice]
    
    @Published var numberOfLetter: Int = 6
    @Published var guessedWord: [Choice] = []
    @Published var nextInputFlag = 0
    
    init(choices: [Choice], numberOfLetter: Int) {
        self.choices = choices
        self.numberOfLetter = numberOfLetter
    }
    
    func setupQuestion(){
        if guessedWord.isEmpty {
            guessedWord = Array(repeating: Choice(choiceID: -1, choiceText: ""), count: numberOfLetter)
        }
    }
    
    func checkNextEmptyIndex(substring: [Choice]) -> Int {
        var nextInputFlag = 0
        if let nextIndex = substring.firstIndex(where: { $0.choiceID == -1 }) {
            nextInputFlag = nextIndex
        } else {
            nextInputFlag = substring.count
        }
        return nextInputFlag
    }
    
    func removeCharacterFromAnswer(index: Int){
        if guessedWord[index].choiceID != -1 {
            choices.append(guessedWord[index])
            guessedWord[index] = Choice(choiceID: -1, choiceText: "")
            nextInputFlag = checkNextEmptyIndex(substring: guessedWord)
        }
    }
    
    func addCharacterToAnswer(choosed: Choice){
        if nextInputFlag < guessedWord.count {
            choices.removeAll { $0.choiceID == choosed.choiceID }
            guessedWord[nextInputFlag] = choosed
            nextInputFlag =  checkNextEmptyIndex(substring: guessedWord)
        }
    }
}
