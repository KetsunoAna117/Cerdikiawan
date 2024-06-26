//
//  ContentView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(QuizModelData.self) private var modelData
    
    var body: some View {
        NavigationStack {
            VStack {
                QuizFillBlankView(
                    vm: QuizFillBlankViewModel(
                        quizFillBlankModel: modelData.rumpang4[0]
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
//            .navigationDestination(isPresented: $isDirected) {
//                QuizView(vm: vm)
//                    .environment(QuizModelData())
//            }
        }
    }
}

#Preview {
    ContentView()
        .environment(QuizModelData())
}
