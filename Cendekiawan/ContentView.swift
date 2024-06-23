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
                    Choice(choiceID: 1, choiceText: "Sigma"),
                    Choice(choiceID: 2, choiceText: "Skibidi"),
                    Choice(choiceID: 3, choiceText: "L Rizz"),
                    Choice(choiceID: 4, choiceText: "Gyatt")
                ]
            ))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
