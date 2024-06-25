//
//  ContentView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(QuizModelData.self) private var modelData
    @ObservedObject var vm: QuizViewModel = QuizViewModel(nextQuiz: ("MultiChoice", "implisit"))
    @State private var isDirected = false
    
    var body: some View {
        NavigationStack {
            VStack {
                QuizFillBlankView(
                    vm: QuizFillBlankViewModel(
                        questions: modelData.rumpang4[0].quizStory,
                        choices: modelData.rumpang4[0].quizChoiceList
                    )
                )
                .preferredColorScheme(.light)
                    .environment(QuizModelData())
//                Button(action: {
//                    vm.valueProgressBar = 0
//                    isDirected = true
//                    vm.startGameplay()
//                }, label: {
//                    Text("Play")
//                })
            }
            .navigationDestination(isPresented: $isDirected) {
                QuizView(vm: vm)
                    .environment(QuizModelData())
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(QuizModelData())
}
