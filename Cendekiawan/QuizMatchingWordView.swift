//
//  QuizMatchingWordView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 20/06/24.
//

import SwiftUI

struct QuizMatchingWordView: View {
    @State var choiceLeft: [Choice]
    @State var choiceRight: [Choice]
    var question: String
    @StateObject private var user: User = User(name: "Test")
    @Environment(QuizModelData.self) private var modelData
    @State private var nextQuiz: (quizModel: String, tipeQuiz: String)?
    @State private var isDone: Bool = false
    
    @StateObject private var vm: QuizMatchingWordViewModel = QuizMatchingWordViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                // buat checking aja. nanti dihapus
//                StatsOverlay()
                VStack() {
                    Text(question)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 50) {
                            ForEach(choiceLeft) { choice in
                                ConnectBoxView(choice: choice, boxColor: vm.boxShouldActive(choiceID: choice.choiceId, selectedFrom: "Left") ? Color.blue : Color.gray, selectedFrom: "Left")
                                    .onTapGesture {
                                        vm.handleSelection(choiceId: choice.choiceId, selectedFrom: "Left")
                                    }
                                    .frame(maxWidth: 243, maxHeight: 71)
                            }
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 50) {
                            ForEach(choiceRight) { choice in
                                ConnectBoxView(choice: choice, boxColor: vm.boxShouldActive(choiceID: choice.choiceId, selectedFrom: "Right") ? Color.blue : Color.gray, selectedFrom: "Right")
                                    .onTapGesture {
                                        vm.handleSelection(choiceId: choice.choiceId, selectedFrom: "Right")
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
                    
                    LineConnectionView(connections: vm.getAllConnections(choiceLeft: choiceLeft, choiceRight: choiceRight))
                        .overlay{
                            //TODO: I think this better be swapped to Quiz view
                            VStack{
                                Spacer()
                                BottomConfirmOverlayView(isCorrect: false, description: "", button: Button3D(text: "Periksa", color: Color.greyMid), action: {
                                    
                                })
                            }
                        }
                }
//                HStack{
//                    Button{
//                        startGameplay()
//                        updateKosakataProeficiency(user: user, win: true)
//                    } label: {
//                        Text("Benar")
//                            .font(.system(size: 50))
//                            .foregroundStyle(.white)
//                            .padding()
//                            .background(.green)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                    Button{
//                        startGameplay()
//                        updateKosakataProeficiency(user: user, win: false)
//                    } label: {
//                        Text("Salah")
//                            .font(.system(size: 50))
//                            .foregroundStyle(.white)
//                            .padding()
//                            .background(.red)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                }
                
            }
            .onAppear {
                isDone = false
            }
            .navigationDestination(isPresented: $isDone){
                getDestinationView()
            }
        }
        
    }
    func startGameplay() {
        let storeRandomizedQuiz: (String, String) = getRandomizedProficiency(ProficiencyLevelStorage(idePokok: user.proficiencyLevelIdePokok, kosakata: user.proficiencyLevelKosakata, implisit: user.proficiencyLevelImplisit))
        let (quizModel, tipeQuiz) = storeRandomizedQuiz
        print("\(quizModel), \(tipeQuiz)")
        
        nextQuiz = (quizModel, tipeQuiz)
        
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
    NavigationStack {
        QuizMatchingWordView(
            choiceLeft: [
                Choice(choiceId: 1, choiceDescription: "Rendah Hati"),
                Choice(choiceId: 2, choiceDescription: "Gulung Tikar"),
                Choice(choiceId: 3, choiceDescription: "Naik Daun"),
                Choice(choiceId: 4, choiceDescription: "Naik Daun"),
                Choice(choiceId: 5, choiceDescription: "Naik Daun"),
            ],
            choiceRight: [
                Choice(choiceId: 1, choiceDescription: "Tidak Sombong"),
                Choice(choiceId: 2, choiceDescription: "Terkenal"),
                Choice(choiceId: 3, choiceDescription: "Bangkrut"),
                Choice(choiceId: 4, choiceDescription: "Naik Daun"),
                Choice(choiceId: 5, choiceDescription: "Naik Daun"),
            ],
            question: "Pasangkan idiom dibawah dengan pengertian yang tepat!")
        .environment(QuizModelData())
    }
}
