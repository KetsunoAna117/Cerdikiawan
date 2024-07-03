//
//  QuizMatchingWordView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 20/06/24.
//

import SwiftUI

struct QuizMatchingWordView: View {
    @Environment(QuizModelData.self) private var modelData
    @StateObject var vm: QuizMatchingWordViewModel
    @ObservedObject var vm2: QuizViewModel
    @State var checkisCorrect: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text(vm.quizConnect?.quizPrompt ?? "")
                    .font(.title3)
                    .fontWeight(.bold)
                
                HStack {
                    VStack(alignment: .leading, spacing: 50) {
                        ForEach(vm.quizConnect?.quizLeftChoiceList ?? []) { choice in
                            ConnectBoxView(choice: choice, boxColor: vm.checkBoxColor(choiceId: choice.choiceId, selectedFrom: "Left"), selectedFrom: "Left")
                                .onTapGesture {
                                    if !vm.isChecked {
                                        vm.handleSelection(choiceId: choice.choiceId, selectedFrom: "Left")
                                    }
                                }
                                .frame(maxWidth: 243, maxHeight: 71)
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 50) {
                        ForEach(vm.quizConnect?.quizRightChoiceList ?? []) { choice in
                            ConnectBoxView(choice: choice, boxColor: vm.checkBoxColor(choiceId: choice.choiceId, selectedFrom: "Right"), selectedFrom: "Right")
                                .onTapGesture {
                                    if !vm.isChecked {
                                        vm.handleSelection(choiceId: choice.choiceId, selectedFrom: "Right")
                                    }
                                }
                                .frame(maxWidth: 243, maxHeight: 71)
                        }
                    }
                }
                .padding(.top, 50)
                .frame(maxWidth: 700, alignment: .center)
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .overlay {
                LineConnectionView(connections: vm.getAllConnections(choiceLeft: vm.quizConnect?.quizLeftChoiceList ?? [], choiceRight: vm.quizConnect?.quizRightChoiceList ?? []))
                
            }
            .overlay{
                VStack{
                    Spacer()
                    BottomConfirmOverlayView(isCorrect: checkisCorrect, description: vm.quizConnect?.quizFeedback.feedbackDescription ?? "", button: Button3D(text: vm.isChecked ? "Lanjut" : "Periksa", color: vm.checkFilled() ? Color.cerdikiawanOrange : Color.cerdikiawanGreyMid), action: {
                        if vm.isChecked{
                            vm2.startGameplay(correct: checkisCorrect)
                        } else if vm.checkFilled(){
                            vm.isChecked = true
                            checkisCorrect = vm.checkAnswer()
                        }
                    }, feedback: (vm.quizConnect?.quizFeedback.feedbackDescription)!)
                }
            }
            
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    QuizMatchingWordView(vm: QuizMatchingWordViewModel(model: getQuizConnectFromJSON()), vm2: QuizViewModel(nextQuiz: ("MultiChoice", "implisit")))
        .environment(QuizModelData())
}

// TODO: Let your code lives inside a class or struct (PAK HAR :D)
func getQuizConnectFromJSON() -> QuizConnect{
    return QuizConnect(
        quizId: 1,
        quizFeedback: Feedback(quizId: 1, feedbackDescription: "You are stupid ah fuck"),
        quizDifficultyLevel: 4,
        quizCategory: "sambung kata",
        quizTitle: "nil",
        quizAsset: ["nil"],
        isRedemption: false,
        quizPrompt: "Pasangkan idiom dibawah ini dengan pasangannya yang tepat",
        quizLeftChoiceList: [
            Choice(choiceId: 1, choiceDescription: "Rendah Hati"),
            Choice(choiceId: 2, choiceDescription: "Gulung Tikar"),
            Choice(choiceId: 3, choiceDescription: "Naik Daun")
        ],
        quizRightChoiceList: [
            Choice(choiceId: 1, choiceDescription: "Tidak Sombong"),
            Choice(choiceId: 2, choiceDescription: "Terkenal"),
            Choice(choiceId: 3, choiceDescription: "Bangkrut"),
        ]
    )
}
