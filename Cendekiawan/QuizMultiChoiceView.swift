//
//  QuizMultiChoiceView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct QuizMultiChoiceView: View {
    @StateObject private var user: User = User(name: "Test")
    @Environment(QuizModelData.self) private var modelData
    @State private var nextQuiz: (quizModel: String, tipeQuiz: String)?
    @State private var isDone: Bool = false
    
    @ObservedObject var vm: QuizMultipleChoiceViewModel
    
//    var tipeQuiz: String
//    private var quiz: QuizMultiChoice {
//        if tipeQuiz == "idePokok"{
//            (modelData.getIdePokok(difficulty: user.difficultyLevel)?.randomElement())!
//        } else {
//            (modelData.getimplisit(difficulty: user.difficultyLevel)?.randomElement())!
//        }
//    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top) {
                        // TODO: Increase readability: for all the view inside the vstack that involved a various of stacks, consider to create a function that represent each (function of UI) view. Create an identifiable function name and let the function recieve parameters (a data or vm that holds the information the view needs to decide its behavior). Let the padding and all view positioning value to be a configurable variable consistently maintained as a single source.
                        // aku ganti jadi scrollview
                        ScrollView {
                            Text(vm.quizMultiChoice.quizTitle)
                                .padding([.bottom], 20)
                            
                            // image name diganti jadi pake modelData
                            Image(vm.quizMultiChoice.quizAsset[0])
                                .padding([.bottom], 50)
                            
                            // untuk formatting seperti menjorok (tab) dan enter bisa ditambahin \t dan \n di jsonnya
                            Text(vm.quizMultiChoice.quizStory)
                        }
                        .frame(maxWidth: geometry.size.width * 0.6)
                        Spacer(minLength: 20)
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Pertanyaan")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text(vm.quizMultiChoice.quizQuestion)
                            
                            ForEach(vm.quizMultiChoice.quizChoiceList, id: \.choiceId) { choice in
                                AnswerButton(boxColor: vm.checkBoxColor(choice: choice), choice: Choice(choiceId: choice.choiceId, choiceDescription: choice.choiceDescription))
                                    .onTapGesture {
                                        if !vm.isChecked {
                                            vm.selectedAnswerChoiceId = choice.choiceId
                                        }
                                    }
                            }
                            
                            if vm.isChecked {
                                //TODO: Change later for feedback
                                VStack (alignment: .leading) {
                                    Text(vm.checkAnswer() ?
                                        "Hore! Jawaban Kamu benar!" :
                                        "Yuk dibaca lagi kamu pasti bisa!"
                                    ).font(.headline)
                                        .fontWeight(.bold)
                                    HStack {
                                        Image(systemName: vm.checkAnswer() ? "checkmark.circle.fill" : "x.circle.fill")
                                            .resizable()
                                            .foregroundStyle(vm.checkAnswer() ? Color.cerdikiawanGreenTua:Color.cerdikiawanRed)
                                            .frame(width: 23, height: 23)
                                        Text(vm.quizMultiChoice.quizFeedback.feedbackDescription)
                                    }
                                }
                                
                                Spacer()
                            } else {
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                Button {
                                    if vm.selectedAnswerChoiceId != -1 {
                                        vm.isChecked = true
                                    }
                                } label : {
                                    Button3D(text: vm.isChecked ? "Lanjut" : "Periksa", color: vm.selectedAnswerChoiceId == -1 ? Color.cerdikiawanGreyMid : Color.cerdikiawanOrange)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 21)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.cerdikiawanYellowMuda)
                            )
                        .frame(maxWidth: geometry.size.width * 0.4)
                    }
                    .padding(50)
            
        }
    }
    
}

#Preview {
    QuizMultiChoiceView(vm: QuizMultipleChoiceViewModel(model: getQuizMultiChoiceFromJSON()))
        .environment(QuizModelData())
}

func getQuizMultiChoiceFromJSON() -> QuizMultiChoice {
    return QuizMultiChoice(
        quizId: 1,
        quizFeedback: Feedback(quizId: 1, feedbackDescription: "You are stupid ah fuck"),
        quizDifficultyLevel: 4,
        quizCategory: "idePokok",
        quizTitle: "nil",
        isRedemption: false,
        quizAsset: ["placeholderPhoto"],
        quizStory: "fbsdfkvnfdsakfjbdnsk fsdfhsfjsdkfm sDFdsnfjsdanfjkasf sdfjnasdkjfnasjkf sadfnjkasdnfsadjnf",
        quizQuestion: "sdhbdsxjhvbsdjhfndsjf?",
        quizChoiceList: [
            Choice(choiceId: 0, choiceDescription: "Jawaban A"),
            Choice(choiceId: 1, choiceDescription: "Jawaban B"),
            Choice(choiceId: 2, choiceDescription: "Jawaban C"),
            Choice(choiceId: 3, choiceDescription: "Jawaban D")
        ],
        quizAnswerId: 1
    )
}
