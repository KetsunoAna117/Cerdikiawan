//
//  ContentView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            QuizFillBlankView(vm: QuizFillBlankViewModel(
                questions: "Apa yang dicari orang __________ Bintang __________  Tanpa itu, kita mempunyai __________ dan tidak akan mendapatkan __________.",
                choices: [
                    Choice(choiceId: 1, choiceDescription: "Sigma"),
                    Choice(choiceId: 2, choiceDescription: "Skibidi"),
                    Choice(choiceId: 3, choiceDescription: "L Rizz"),
                    Choice(choiceId: 4, choiceDescription: "Gyatt")
                ]
            ))
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(QuizModelData())
}
