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
    
    var tipeQuiz: String
    private var quiz: QuizMultiChoice {
        if tipeQuiz == "idePokok"{
            (modelData.getIdePokok(difficulty: user.difficultyLevel)?.randomElement())!
        } else {
            (modelData.getimplisit(difficulty: user.difficultyLevel)?.randomElement())!
        }
    }
    
    @State var selectedAnswer: Int?
    
    var body: some View {
        NavigationStack {
            VStack {
                // buat checking aja. nanti dihapus
                StatsOverlay()
                HStack {
                    // aku ganti jadi scrollview
                    ScrollView {
                        Text(quiz.quizTitle)
                            .padding([.bottom], 20)
                        
                        // image name diganti jadi pake modelData
                        Image("placeholderPhoto")
                            .padding([.bottom], 50)
                        
                        // untuk formatting seperti menjorok (tab) dan enter bisa ditambahin \t dan \n di jsonnya
                        Text(quiz.quizStory)
                    }
                    .frame(maxWidth: .infinity)
                    Spacer(minLength: 20)
                    VStack(alignment: .leading, spacing: 20) {
                        Text(quiz.quizQuestion)
                        
                        ForEach(quiz.quizChoiceList, id: \.choiceId) { choice in
                            AnswerButton(isClicked: choice.choiceId == selectedAnswer, choice: Choice(choiceId: choice.choiceId, choiceDescription: choice.choiceDescription))
                                .onTapGesture {
                                    selectedAnswer = choice.choiceId
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(50)
                HStack {
                    Button {
                        // print(user.difficultyLevel)
                        if tipeQuiz == "idePokok" {
                            updateIdePokokProeficiency(user: user, win: true)
                        } else {
                            updateImplisitProeficiency(user: user, win: true)
                        }
                        startGameplay()
                    } label: {
                        Text("Benar")
                            .font(.system(size: 50))
                            .foregroundStyle(.white)
                            .padding()
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Button {
                        // print(user.difficultyLevel)
                        if tipeQuiz == "idePokok" {
                            updateIdePokokProeficiency(user: user, win: false)
                        } else {
                            updateImplisitProeficiency(user: user, win: false)
                        }
                        startGameplay()
                    } label: {
                        Text("Salah")
                            .font(.system(size: 50))
                            .foregroundStyle(.white)
                            .padding()
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .navigationDestination(isPresented: $isDone) {
                getDestinationView()
            }
        }
    }
    
    func startGameplay() {
        let storeRandomizedQuiz: (String, String) = getRandomizedProficiency(ProficiencyLevelStorage(idePokok: user.proficiencyLevelIdePokok, kosakata: user.proficiencyLevelKosakata, implisit: user.proficiencyLevelImplisit))
        let (quizModel, tipeQuiz) = storeRandomizedQuiz
        
        nextQuiz = (quizModel, tipeQuiz)
        print("\(nextQuiz!.quizModel), \(nextQuiz!.tipeQuiz)")
        
        isDone = true
    }
    
    @ViewBuilder
    func getDestinationView() -> some View {
        
        if let tipeQuizz = nextQuiz?.tipeQuiz, let quizModel = nextQuiz?.quizModel {
            
            switch tipeQuizz {
            case "kosakata":
                switch quizModel {
                case "FillBlank":
                    let fillBlankQuiz = modelData.getRumpang(difficulty: user.difficultyLevel)?.randomElement()
                    
                    // TODO: tambahin parameter judul buat soal
                    QuizFillBlankView(vm: QuizFillBlankViewModel(
                        questions: fillBlankQuiz!.quizStory,
                        choices: fillBlankQuiz!.quizChoiceList
                    ))
                    .environment(modelData)
                case "WordBlank":
                    let wordBlankQuiz = modelData.getWordle(difficulty: user.difficultyLevel)?.randomElement()
                    QuizWordBlankView(
                        vm: QuizWordBlankViewModel(
                            choices: wordBlankQuiz!.quizLetterChoiceList,
                            numberOfLetter: wordBlankQuiz!.quizLetterCount
                        ),
                        question: wordBlankQuiz!.quizPrompt
                    )
                    .environment(modelData)
                default:
                    let matchingWordQuizz = modelData.getSambung(difficulty: user.difficultyLevel)?.randomElement()
                    QuizMatchingWordView(
                        choiceLeft: matchingWordQuizz!.quizLeftChoiceList,
                        choiceRight: matchingWordQuizz!.quizRightChoiceList,
                        question: matchingWordQuizz!.quizPrompt
                    )
                    .environment(modelData)
                }
            default:
                //TODO: pindahin logic ke view model
                QuizMultiChoiceView(tipeQuiz: nextQuiz!.tipeQuiz)
                    .environment(modelData)
            }
        } else {
            Text("Error: No destination view")
        }
    }
}

#Preview {
    QuizMultiChoiceView(tipeQuiz: "implisit")
        .environment(QuizModelData())
}
