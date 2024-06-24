//
//  HomeView.swift
//  Cendekiawan
//
//  Created by Roland Ramadan on 23/06/24.
//

import SwiftUI

import SwiftUI

//TODO: PENTING next soal masih bisa kepilih 2 kali
struct HomeView: View {
    @StateObject private var user: User = User(name: "Test")
    @Environment(QuizModelData.self) private var modelData
    @State private var quizModel: String?
    @State private var tipeQuiz: String?
    @State var isDone: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    startGameplay()
                }, label: {
                    Text("Play")
                        .font(.system(size: 100))
                })
                .padding()
                .border(Color.black)
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
        
        self.quizModel = quizModel
        self.tipeQuiz = tipeQuiz
        
        isDone = true
    }
    
    @ViewBuilder
    func getDestinationView() -> some View {
        if let tipeQuiz = tipeQuiz, let quizModel = quizModel {
            switch tipeQuiz {
            case "kosakata":
                switch quizModel {
                case "FillBlank":
                    let fillBlankQuiz = modelData.getRumpang(difficulty: user.difficultyLevel)?.first
                    
                    // TODO: tambahin parameter judul buat soal
                    QuizFillBlankView(vm: QuizFillBlankViewModel(
                        questions: fillBlankQuiz!.quizStory,
                        choices: loadChoices(
                            storeChoice: fillBlankQuiz!.quizChoiceList
                        )
                    ))
                    .environment(modelData)
                case "WordBlank":
                    let wordBlankQuiz = modelData.getWordle(difficulty: user.difficultyLevel)?.first
                    QuizWordBlankView(
                        vm: QuizWordBlankViewModel(
                            choices: loadChoices(
                                storeChoice: wordBlankQuiz!.quizLetterChoiceList
                            ),
                            numberOfLetter: wordBlankQuiz!.quizLetterCount
                        ),
                        question: wordBlankQuiz!.quizPrompt
                    )
                    .environment(modelData)
                default:
                    let matchingWordQuizz = modelData.getSambung(difficulty: user.difficultyLevel)?.first
                    QuizMatchingWordView(
                        choiceLeft: loadChoices(storeChoice: matchingWordQuizz!.quizLeftChoiceList),
                        choiceRight: loadChoices(storeChoice: matchingWordQuizz!.quizRightChoiceList),
                        question: matchingWordQuizz!.quizPrompt
                    )
                    .environment(modelData)
                }
            default:
                //TODO: pindahin logic ke view model
                QuizMultiChoiceView(tipeQuiz: tipeQuiz)
                    .environment(modelData)
            }
        } else {
            Text("Error: No destination view")
        }
    }
    
    func loadChoices(storeChoice: [StoreChoice]) -> [Choice]{
        var choices: [Choice] = []
        for choice in storeChoice{
            choices.append(Choice(choiceId: choice.choiceId, choiceDescription: choice.choiceDescription))
        }
        
        return choices
    }
}

#Preview {
    HomeView()
        .environment(QuizModelData())
}
