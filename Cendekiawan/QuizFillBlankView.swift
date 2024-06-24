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
    
    private var quiz: QuizFillBlank {
        modelData.rumpang4[0]
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                //                StatsOverlay() // For debugging, can be removed later
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
                                renderTextWithPlaceHolders(availableWidth: 400)
                            }
                            Spacer()
                        }
                    }
                    VStack {
                        Text("Masukkan kata yang tepat untuk setiap kata yang rumpang dalam teks!")
                            .font(.title3)
                            .fontWeight(.bold)
                        ChoicePoolView(choices: vm.choices, width: 400)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.4)
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
        .padding(.horizontal, 50)
    }
    
    func renderTextWithPlaceHolders(availableWidth: CGFloat) -> some View {
        let parts = vm.questions.components(separatedBy: "___")
        var views: [AnyView] = []
        
        for index in parts.indices {
            views.append(AnyView(
                Text(parts[index])
                    .font(.body)
            ))
            
            if index < parts.indices.last! {
                // this will append rectangle to the paragraph
                views.append(AnyView(
                    DroppableBox(boxText: vm.droppedAnswer.isEmpty ? "" : vm.droppedAnswer[index].choiceDescription)
                        .dropDestination(for: DraggableChoice.self, action: { droppedChoice, location in
                            vm.handleChoiceDrop(index: index, droppedChoice: droppedChoice)
                            return true
                        })
                        .onTapGesture {
                            vm.removeChoicesFromAnswer(index: index)
                        }
                ))
            }
        }
        return VStack {
            FlexibleView(availableWidth: availableWidth, views: views)
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
                            choices: fillBlankQuiz.quizChoiceList
                        ))
                        .environment(modelData)
                    }
                case "WordBlank":
                    if let wordBlankQuiz = modelData.getWordle(difficulty: user.difficultyLevel)?.randomElement() {
                        QuizWordBlankView(
                            vm: QuizWordBlankViewModel(
                                choices: wordBlankQuiz.quizLetterChoiceList,
                                numberOfLetter: wordBlankQuiz.quizLetterCount
                            ),
                            question: wordBlankQuiz.quizPrompt
                        )
                        .environment(modelData)
                    }
                default:
                    if let matchingWordQuizz = modelData.getSambung(difficulty: user.difficultyLevel)?.randomElement() {
                        QuizMatchingWordView(
                            choiceLeft: matchingWordQuizz.quizLeftChoiceList,
                            choiceRight: matchingWordQuizz.quizRightChoiceList,
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
}

#Preview {
    QuizFillBlankView(
        vm: QuizFillBlankViewModel(
            questions: "Apa yang dicari orang ___? Bintang ___. Tanpa itu, kita mempunyai ___ dan tidak akan mendapatkan ___",
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



