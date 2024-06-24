//
//  QuizWordBlank.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 20/06/24.
//

import SwiftUI

struct QuizWordBlankView: View {
    @ObservedObject var vm: QuizWordBlankViewModel
    var question: String
    @StateObject private var user: User = User(name: "Test")
    @Environment(QuizModelData.self) private var modelData
    @State private var nextQuiz: (quizModel: String, tipeQuiz: String)?
    @State private var isDone: Bool = false
    
    let columns = [
        GridItem(.adaptive(minimum: 48))
    ]
    
    var body: some View {
        
        NavigationStack {
            VStack {
                // buat checking aja. nanti dihapus
                StatsOverlay()
                VStack {
                    Text(question)
                        .font(.body)
                        .padding([.bottom], 30)
                    Image("placeholderPhoto")
                    Spacer()
                    HStack (alignment: .center, spacing: 50) {
                        ForEach (0..<vm.guessedWord.count, id: \.self) { index in
                            VStack {
                                if vm.guessedWord[index].choiceId != -1 {
                                    Text(vm.guessedWord[index].choiceDescription)
                                        .font(.title2)
                                        .fontWeight(.semibold)
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
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .padding([.horizontal], 30)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4)
                            .foregroundColor(Color(.secondarySystemFill))
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach (vm.choices, id: \.choiceId) { choosed in
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 128, height: 34)
                                        .foregroundStyle(Color(.lightGray))
                                    Text(choosed.choiceDescription)
                                        .font(.headline)
                                }
                                .onTapGesture {
                                    vm.addCharacterToAnswer(choosed: choosed)
                                }
                            }
                        }.padding(30)
                    }
                    
                    
                }
                .padding(50)
                .onAppear{
                    vm.setupQuestion()
                }
                HStack{
                    Button{
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
                    Button{
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
    QuizWordBlankView(
        vm: QuizWordBlankViewModel(
            choices: [
                Choice(choiceId: 0, choiceDescription: "A"),
                Choice(choiceId: 1, choiceDescription: "A"),
                Choice(choiceId: 2, choiceDescription: "M"),
                Choice(choiceId: 3, choiceDescription: "I"),
                Choice(choiceId: 4, choiceDescription: "H"),
                Choice(choiceId: 5, choiceDescription: "N"),
                Choice(choiceId: 6, choiceDescription: "E"),
                Choice(choiceId: 7, choiceDescription: "R"),
                Choice(choiceId: 8, choiceDescription: "T"),
                Choice(choiceId: 9, choiceDescription: "A")],
            numberOfLetter: 6
        ),
        question: "Pesan yang disampaikan oleh penulis dalam cerita disebut..."
    )
    .environment(QuizModelData())
}


