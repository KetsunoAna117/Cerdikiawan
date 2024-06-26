//
//  QuizView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 20/06/24.
//

import SwiftUI

struct QuizView: View {
    @State private var quizTitle: String = "Pasang Kata"
    @Environment(QuizModelData.self) private var modelData
    @ObservedObject var vm: QuizViewModel
    @State private var isDone: Bool = false
    @Binding var rootIsActive: Bool
    
    var body: some View {
        VStack {
            HStack{
                Button{
                    rootIsActive = false
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.gray)
                }
                ProgressView(value: Double(vm.valueProgressBar), total: 10)
                        .padding([.horizontal], 52)
            }.padding([.horizontal], 30)
            GeometryReader(content: { geometry in
                VStack {
                    if vm.redemptionIdList.isEmpty && vm.valueProgressBar >= 10{
                        QuizResultView(vm: vm, rootIsActive: $rootIsActive)
                    } else {
                        switch vm.nextQuiz.tipeQuiz {
                        case "kosakata":
                            switch vm.nextQuiz.quizModel {
                            case "FillBlank":
                                QuizFillBlankView(vm: QuizFillBlankViewModel(quizFillBlankModel: vm.getQuizFromId(id: vm.currentQuiz!)), vm2: vm)
                            case "WordBlank":
                                QuizWordBlankView(vm: QuizWordBlankViewModel(model: vm.getQuizFromId(id: vm.currentQuiz!)), vm2: vm)

                            default:
    //                            TestViewMatchingWord()
                                QuizMatchingWordView(vm: QuizMatchingWordViewModel(model: vm.getQuizFromId(id: vm.currentQuiz!)), vm2: vm)
                            }
                            
                        default:
    //                         nambahin multichoice
                            QuizMultiChoiceView(vm: QuizMultipleChoiceViewModel(model: vm.getQuizFromId(id: vm.currentQuiz!)), vm2: vm)
    //                        TestViewMultiChoice(vm: QuizMultipleChoiceViewModel(model: getQuizMultiChoiceFromJSON()), vm2: vm)
                        }
                    }
                }
            })
        }
        .padding([.top], 16)
        .navigationBarBackButtonHidden(true)
        
        // kalo mau testing di quiz view bisa di uncomment ini
        
//        .task {
//            vm.startGameplay()
//        }
    }
}

#Preview {
    NavigationStack {
        QuizView(vm: QuizViewModel(nextQuiz: ("MultiChoice", "implisit")), rootIsActive: .constant(true))
                .environment(QuizModelData())
    }
}
