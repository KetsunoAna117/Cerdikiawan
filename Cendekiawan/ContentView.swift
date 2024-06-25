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
        VStack {
            QuizFillBlankView(vm: QuizFillBlankViewModel(
                questions: modelData.rumpang4[0].quizStory,
                choices: modelData.rumpang4[0].quizChoiceList
            ))
            .environment(modelData)
        }
        .padding()
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
        .environment(QuizModelData())
}
