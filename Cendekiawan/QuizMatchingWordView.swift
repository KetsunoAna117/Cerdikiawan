//
//  QuizMatchingWordView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 20/06/24.
//

import SwiftUI

struct QuizMatchingWordView: View {
    @Binding var choiceLeft: [Choice]
    @Binding var choiceRight: [Choice]
    var question: String
    @StateObject private var user: User = User(name: "Test")
    @Environment(QuizModelData.self) private var modelData
    @State private var nextQuiz: (quizModel: String, tipeQuiz: String)?
    
    @StateObject private var vm: QuizMatchingWordViewModel = QuizMatchingWordViewModel()
    
    var body: some View {
        // buat checking aja. nanti dihapus
        StatsOverlay()
        NavigationStack {
            VStack() {
                HStack {
                    Rectangle()
                        .frame(width: 23, height: 23)
                        .foregroundStyle(Color.gray)
                    Text(question)
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 50) {
                        ForEach(choiceLeft) { choice in
                            ConnectBoxView(choice: choice, boxColor: vm.boxShouldActive(choiceID: choice.choiceId, selectedFrom: "Left") ? Color.blue : Color.gray)
                                .onTapGesture {
                                    vm.handleSelection(choiceId: choice.choiceId, selectedFrom: "Left")
                                }
                                .frame(maxWidth: 155, maxHeight: 75)
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 50) {
                        ForEach(choiceRight) { choice in
                            ConnectBoxView(choice: choice, boxColor: vm.boxShouldActive(choiceID: choice.choiceId, selectedFrom: "Right") ? Color.blue : Color.gray)
                                .onTapGesture {
                                    vm.handleSelection(choiceId: choice.choiceId, selectedFrom: "Right")
                                }
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
            }
            .navigationDestination(isPresented: Binding<Bool>(
                get: { nextQuiz != nil },
                set: { _ in })){
                    getDestinationView()
                }
            HStack{
                Button{
                    startGameplay()
                    user.updateKosakataProeficiency(win: true)
                } label: {
                    Text("Benar")
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                        .padding()
                        .background(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Button{
                    startGameplay()
                    user.updateKosakataProeficiency(win: false)
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
        
    }
    func startGameplay() {
        let storeRandomizedQuiz: (String, String) = getRandomizedProficiency(ProficiencyLevelStorage(idePokok: user.proficiencyLevelIdePokok, kosakata: user.proficiencyLevelKosakata, implisit: user.proficiencyLevelImplisit))
        let (quizModel, tipeQuiz) = storeRandomizedQuiz
        print("\(quizModel), \(tipeQuiz)")
        
        nextQuiz?.quizModel = quizModel
        nextQuiz?.tipeQuiz = tipeQuiz
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
                        choices: loadChoices(
                            storeChoice: fillBlankQuiz!.quizChoiceList
                        )
                    ))
                case "WordBlank":
                    let wordBlankQuiz = modelData.getWordle(difficulty: user.difficultyLevel)?.randomElement()
                    QuizWordBlankView(
                        vm: QuizWordBlankViewModel(
                            choices: loadChoices(
                                storeChoice: wordBlankQuiz!.quizLetterChoiceList
                            ),
                            numberOfLetter: wordBlankQuiz!.quizLetterCount
                        ),
                        question: wordBlankQuiz!.quizPrompt
                    )
                default:
                    let matchingWordQuizz = modelData.getSambung(difficulty: user.difficultyLevel)?.randomElement()
                    QuizMatchingWordView(
                        choiceLeft: .constant(loadChoices(storeChoice: matchingWordQuizz!.quizLeftChoiceList)),
                        choiceRight: .constant(loadChoices(storeChoice: matchingWordQuizz!.quizRightChoiceList)),
                        question: matchingWordQuizz!.quizPrompt
                    )
                }
            default:
                //TODO: pindahin logic ke view model
                QuizMultiChoiceView(tipeQuiz: nextQuiz!.tipeQuiz)
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
    NavigationStack {
        QuizMatchingWordView(
            choiceLeft: .constant([
                Choice(choiceId: 1, choiceDescription: "Rendah Hati"),
                Choice(choiceId: 2, choiceDescription: "Gulung Tikar"),
                Choice(choiceId: 3, choiceDescription: "Naik Daun"),
                Choice(choiceId: 4, choiceDescription: "Naik Daun"),
                Choice(choiceId: 5, choiceDescription: "Naik Daun"),
            ]),
            choiceRight: .constant([
                Choice(choiceId: 1, choiceDescription: "Tidak Sombong"),
                Choice(choiceId: 2, choiceDescription: "Terkenal"),
                Choice(choiceId: 3, choiceDescription: "Bangkrut"),
                Choice(choiceId: 4, choiceDescription: "Naik Daun"),
                Choice(choiceId: 5, choiceDescription: "Naik Daun"),
            ]),
            question: "Memasangkan teks hasil idiom"
        )
        .environment(QuizModelData())
    }
}
