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
        }
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



