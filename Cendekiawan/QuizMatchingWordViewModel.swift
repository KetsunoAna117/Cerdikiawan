//
//  QuizMatchingWordViewModel.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 20/06/24.
//

import Foundation

class QuizMatchingWordViewModel: ObservableObject {
    @Published var leftSelectedChoiceId: Int = 0
    @Published var leftSelectedFrom: Bool = false
    @Published var rightSelectedChoiceId: Int = 0
    @Published var rightSelectedFrom: Bool = false
    
    @Published var listOfCorrectId: [Int] = []
    
    @Published var quizConnect: QuizConnect? = nil
    
    func checkIfChoiceIdTheSame(choiceId: Int, selectedFrom: String){
        // If user haven't selected any box, set either box to true
        if !leftSelectedFrom && selectedFrom == "Left" {
            print("[DEBUG]: LeftID selected: \(leftSelectedChoiceId)")
            leftSelectedChoiceId = choiceId
            leftSelectedFrom = true
        }
        else if !rightSelectedFrom && selectedFrom == "Right" {
            print("[DEBUG]: rightID selected: \(rightSelectedChoiceId)")
            rightSelectedChoiceId = choiceId
            rightSelectedFrom = true
        }
        
        // if user has selected the left side and click on the right side
        if selectedFrom == "Right" && leftSelectedFrom {
            if leftSelectedChoiceId == choiceId {
                print("[DEBUG]: Right is the correct match from left")
                listOfCorrectId.append(choiceId)
            }
            else {
                print("[DEBUG]: Right is the incorrect match from left")
            }
            resetVariables()
        }
        // if user has selected the right side and click on the left side
        else if selectedFrom == "Left" && rightSelectedFrom {
            if rightSelectedChoiceId == choiceId {
                print("[DEBUG]: Left is the correct match from right")
                listOfCorrectId.append(choiceId)
            }
            else {
                print("[DEBUG]: Left is the incorrect match from right")
            }
            resetVariables()
        }
    }
    
    func resetVariables(){
        // if ever reach this part of code, regardless what happens, resets all
        leftSelectedChoiceId = 0
        leftSelectedFrom = false
        rightSelectedChoiceId = 0
        rightSelectedFrom = false
    }
    
    func boxShouldActive(choiceID: Int, selectedFrom: String) -> Bool{
        if selectedFrom == "Left" {
            if leftSelectedChoiceId == choiceID || listOfCorrectId.contains(choiceID) {
                return true
            }
        }
        else if selectedFrom == "Right" {
            if rightSelectedChoiceId == choiceID || listOfCorrectId.contains(choiceID) {
                return true
            }
        }
        return false
    }
    
    func getQuizConnectFromJSON(){
        self.quizConnect = QuizConnect(
            quizId: 1,
            quizFeedback: Feedback(quizID: 1, feedbackDescription: "You are stupid ah fuck"),
            quizDifficultyLevel: 4,
            quizCategory: "sambung kata",
            quizTitle: "nil",
            quizAsset: ["nil"],
            isRedemption: false,
            quizPrompt: "Pasangkan idiom dibawah ini dengan pasangannya yang tepat",
            quizLeftChoiceList: [
                Choice(choiceID: 1, choiceText: "Rendah Hati"),
                Choice(choiceID: 2, choiceText: "Gulung Tikar"),
                Choice(choiceID: 3, choiceText: "Naik Daun")
            ],
            quizRightChoiceList: [
                Choice(choiceID: 1, choiceText: "Tidak Sombong"),
                Choice(choiceID: 2, choiceText: "Terkenal"),
                Choice(choiceID: 3, choiceText: "Bangkrut"),
            ]
        )
    }
}
