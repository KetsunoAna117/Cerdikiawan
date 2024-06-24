//
//  QuizFillBlankView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct QuizFillBlankView: View {
    @Environment(QuizModelData.self) private var modelData
    @ObservedObject var vm: QuizFillBlankViewModel
    @StateObject private var user: User = User(name: "Test")
    @State private var nextQuiz: (quizModel: String, tipeQuiz: String)?
    @State private var isDone: Bool = false
    
    private var quiz: StoreQuizFillBlank {
        modelData.rumpang4[0]
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                StatsOverlay() // For debugging, can be removed later
                HStack {
                    ScrollView {
                        VStack {
                            Text(quiz.quizTitle == "nil" ? "" : quiz.quizTitle)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding([.bottom], 30)
                            Spacer()
                            
                            Image("placeholderPhoto")
                                .padding([.bottom], 30)
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                ForEach(0..<vm.trunc.count, id: \.self) { index in
                                    HStack(alignment: .center) {
                                        Text(vm.trunc[index])
                                        if index < vm.trunc.count - 1 {
                                            Spacer()
                                            DroppableBox(boxText: vm.droppedAnswer.isEmpty ? "" : vm.droppedAnswer[index].choiceDescription)
                                                .dropDestination(for: DraggableChoice.self) { droppedChoice, location in
                                                    vm.handleChoiceDrop(index: index, droppedChoice: droppedChoice)
                                                    return true
                                                }
                                                .onTapGesture {
                                                    vm.removeChoicesFromAnswer(index: index)
                                                }
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    }
                    Spacer(minLength: 20)
                    VStack {
                        Text("Masukkan kata yang tepat untuk setiap kata yang rumpang dalam teks!")
                            .font(.title3)
                            .fontWeight(.bold)
                        ChoicePoolView(choices: vm.choices)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(50)
                .onAppear {
                    vm.setupQuestion()
                }
                HStack {
                    Button {
                        startGameplay()
                        updateKosakataProeficiency(user: user, win: true)
                    } label: {
                        Text("Benar")
                            .font(.system(size: 50))
                            .foregroundStyle(.white)
                            .padding()
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Button {
                        startGameplay()
                        updateKosakataProeficiency(user: user, win: false)
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
            .onAppear {
                isDone = false
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
        isDone = true
    }
    
    @ViewBuilder
    func getDestinationView() -> some View {
        if let tipeQuizz = nextQuiz?.tipeQuiz, let quizModel = nextQuiz?.quizModel {
            switch tipeQuizz {
            case "kosakata":
                switch quizModel {
                case "FillBlank":
                    if let fillBlankQuiz = modelData.getRumpang(difficulty: user.difficultyLevel)?.randomElement() {
                        QuizFillBlankView(vm: QuizFillBlankViewModel(
                            questions: fillBlankQuiz.quizStory,
                            choices: loadChoices(storeChoice: fillBlankQuiz.quizChoiceList)
                        ))
                        .environment(modelData)
                    }
                case "WordBlank":
                    if let wordBlankQuiz = modelData.getWordle(difficulty: user.difficultyLevel)?.randomElement() {
                        QuizWordBlankView(
                            vm: QuizWordBlankViewModel(
                                choices: loadChoices(storeChoice: wordBlankQuiz.quizLetterChoiceList),
                                numberOfLetter: wordBlankQuiz.quizLetterCount
                            ),
                            question: wordBlankQuiz.quizPrompt
                        )
                        .environment(modelData)
                    }
                default:
                    if let matchingWordQuizz = modelData.getSambung(difficulty: user.difficultyLevel)?.randomElement() {
                        QuizMatchingWordView(
                            choiceLeft: loadChoices(storeChoice: matchingWordQuizz.quizLeftChoiceList),
                            choiceRight: loadChoices(storeChoice: matchingWordQuizz.quizRightChoiceList),
                            question: matchingWordQuizz.quizPrompt
                        )
                        .environment(modelData)
                    }
                }
            default:
                QuizMultiChoiceView(tipeQuiz: nextQuiz!.tipeQuiz)
                    .environment(modelData)
            }
        } else {
            Text("Error: No destination view")
        }
    }
    
    func loadChoices(storeChoice: [StoreChoice]) -> [Choice] {
        storeChoice.map { Choice(choiceId: $0.choiceId, choiceDescription: $0.choiceDescription) }
    }
}

#Preview {
    QuizFillBlankView(
        vm: QuizFillBlankViewModel(
            questions: "Apa yang dicari orang __________? Bintang __________. Kita Tanpa itu, kita mempunyai __________ dan tidak akan mendapatkan __________",
            choices: [
                Choice(choiceId: 1, choiceDescription: "Sigma"),
                Choice(choiceId: 2, choiceDescription: "Skibidi"),
                Choice(choiceId: 3, choiceDescription: "L Rizz"),
                Choice(choiceId: 4, choiceDescription: "Gyatt")
            ]
        )
    )
    .environment(QuizModelData())
}



