//
//  QuizWordBlank.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 20/06/24.
//

import SwiftUI

struct QuizWordBlankView: View {
    @ObservedObject var vm: QuizWordBlankViewModel
    
    @StateObject private var user: User = User(name: "Test")
    @Environment(QuizModelData.self) private var modelData
    @State private var nextQuiz: (quizModel: String, tipeQuiz: String)?
    @State private var isDone: Bool = false
    
    let columns = [
        GridItem(.adaptive(minimum: 48))
    ]
    
    var body: some View {
                VStack {
                    Text(vm.quizWordBlank?.quizPrompt ?? "")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding([.bottom], 30)
                    Image("placeholderPhoto")
                    Spacer()
                    HStack (alignment: .center, spacing: 50) {
                        ForEach (0..<vm.guessedWord.count, id: \.self) { index in
                            VStack {
                                if vm.guessedWord[index].choiceId != -1 {
                                    Button3D(text: vm.guessedWord[index].choiceDescription, color: vm.checkBoxColor(state: "Selected", choice: vm.guessedWord[index]))
                                }else {
                                    Text(" ")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    
                                }
                                Text("_____")
                            }
                            .onTapGesture {
                                vm.removeCharacterFromAnswer(index: index)
                            }
                        }
                    }
                    .padding([.bottom], 56)
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.cerdikiawanGreyMid, lineWidth: 3)
                            .frame(width: 437, height: 155)
                            .padding([.horizontal], 30)
                        LazyVGrid(columns: columns, spacing: 32) {
                            ForEach (vm.quizWordBlank?.quizLetterChoiceList ?? [], id: \.choiceId) { choosed in
                                Button3D(text: choosed.choiceDescription, color: vm.checkBoxColor(state: "Unselected", choice: choosed)
                                )
                                .onTapGesture {
                                    vm.addCharacterToAnswer(choosed: choosed)
                                }
                            }
                        }.frame(width: 344, height: 102)
                        .padding(30)
                    }
                }
                .padding([.bottom], 132)
                .onAppear{
                    vm.setupQuestion()
                }
                .frame(minWidth: UIScreen.main.bounds.width)
        .onAppear {
            isDone = false
        }
        .overlay{
            VStack{
                Spacer()
                BottomConfirmOverlayView(isCorrect: false, description: "", button: Button3D(text: "Periksa", color: Color.cerdikiawanGreyMid), action: {
                    vm.isChecked = true
                })
            }
        }
    }
    
    

}

#Preview {
    QuizWordBlankView(
        vm: QuizWordBlankViewModel(model: getQuizWordBlankfromJSON())
        )
    .environment(QuizModelData())
}

func getQuizWordBlankfromJSON() -> QuizWordBlank{
    return QuizWordBlank(
        quizId: 1,
        quizFeedback: Feedback(quizId: 1, feedbackDescription: "You are stupid ah fuck"),
        quizDifficultyLevel: 4,
        quizCategory: "kosakata",
        quizTitle: "nil",
        quizAsset: ["nil"],
        isRedemption: false,
        quizPrompt: "Pesan yang disampaikan oleh penulis dalam cerita disebut...",
        quizLetterCount: 6,
        quizLetterChoiceList: [
            Choice(choiceId: 0, choiceDescription: "A"),
            Choice(choiceId: 1, choiceDescription: "A"),
            Choice(choiceId: 2, choiceDescription: "M"),
            Choice(choiceId: 3, choiceDescription: "I"),
            Choice(choiceId: 4, choiceDescription: "H"),
            Choice(choiceId: 5, choiceDescription: "N"),
            Choice(choiceId: 6, choiceDescription: "E"),
            Choice(choiceId: 7, choiceDescription: "R"),
            Choice(choiceId: 8, choiceDescription: "T"),
            Choice(choiceId: 9, choiceDescription: "A")
        ],
        quizAnswer: "AMANAT"
    )
}



