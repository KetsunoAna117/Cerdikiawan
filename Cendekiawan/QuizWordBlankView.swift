//
//  QuizWordBlank.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 20/06/24.
//

import SwiftUI

struct QuizWordBlankView: View {
    @ObservedObject var vm: QuizWordBlankViewModel
    
    //to navigate user to another question by sending the same VM
    @ObservedObject var vm2: QuizViewModel
    
    @StateObject private var user: User = User(name: "Test")
    @Environment(QuizModelData.self) private var modelData
    @State private var nextQuiz: (quizModel: String, tipeQuiz: String)?
    @State var checkisCorrect: Bool = false
    
    let columns = [
        GridItem(.adaptive(minimum: 48))
    ]
    
    var body: some View {
        // TODO: Increase readability: for all the view inside the vstack that involved a various of stacks, consider to create a function that represent each (function of UI) view. Create an identifiable function name and let the function recieve parameters (a data or vm that holds the information the view needs to decide its behavior). Let the padding and all view positioning value to be a configurable variable consistently maintained as a single source.
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
                    // TODO: Increase readability: for all the view inside the vstack that involved a various of stacks, consider to create a function that represent each (function of UI) view. Create an identifiable function name and let the function recieve parameters (a data or vm that holds the information the view needs to decide its behavior). Let the padding and all view positioning value to be a configurable variable consistently maintained as a single source.
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
        .overlay{
            VStack{
                Spacer()
                BottomConfirmOverlayView(isCorrect: checkisCorrect, description: "", button: Button3D(text: vm.isChecked ? "Lanjut" : "Periksa", color: Color.cerdikiawanGreyMid), action: {
                    if vm.isChecked{
                        vm2.startGameplay(correct: checkisCorrect)
                    }
                    checkisCorrect = vm.checkAnswer()
                    vm.isChecked = true
                })
            }
        }
    }
    
    

}

#Preview {
    QuizWordBlankView(
        vm: QuizWordBlankViewModel(model: getQuizWordBlankfromJSON()), vm2: QuizViewModel(nextQuiz: ("MultiChoice", "implisit"))
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
