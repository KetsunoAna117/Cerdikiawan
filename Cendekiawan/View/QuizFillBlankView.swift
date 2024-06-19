//
//  QuizFillBlankView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct QuizFillBlankView: View {
    @State var questions = "Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem -?- sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem -?- Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem -?- Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem -?- sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet "
//    @State private var answers
    var body: some View {
        Text("Fill In The Blank")
        ChoicePoolView(choices: [DraggableChoice(choiceId: 1, choiceDescription: "Pilihan 1"),
            DraggableChoice(choiceId: 2, choiceDescription: "Pilihan 2"),
            DraggableChoice(choiceId: 3, choiceDescription: "Pilihan 3"),
            ])
    }
}

#Preview {
    QuizFillBlankView()
}
