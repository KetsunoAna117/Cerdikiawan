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
    
    private var quiz: StoreQuizFillBlank{
        modelData.rumpang4[0]
    }
    
    var body: some View {
        
        NavigationStack {
            // buat checking aja. nanti dihapus
            StatsOverlay()
            HStack{
                ScrollView {
                    VStack {
                        Text(quiz.quizTitle == "nil" ? "": quiz.quizTitle)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding([.bottom], 30)
                        Spacer()
                        
                        // image name diganti pake modeldata
                        Image("placeholderPhoto")
                            .padding([.bottom], 30)
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            ForEach (0..<vm.trunc.count, id: \.self) { index in
                                HStack(alignment: .center){
                                    Text(vm.trunc[index])
                                    if index < vm.trunc.count - 1{
                                        Spacer()
                                        DroppableBox(boxText: vm.droppedAnswer.isEmpty ? "" : vm.droppedAnswer[index].choiceDescription)
                                            .dropDestination(for: DraggableChoice.self) { droppedChoice, location in
                                                print(index)
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
                VStack{
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
        
        nextQuiz = (quizModel, tipeQuiz)
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
