//
//  QuizFillBlankView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct QuizFillBlankView: View {
    @State var questions = "Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem -?- sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem -?- Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem -?- Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem -?- sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet "
    @State private var choices: [DraggableChoice] = [
        DraggableChoice(choiceID: 1, choiceText: "jawaban A"),
        DraggableChoice(choiceID: 2, choiceText: "jawaban B"),
        DraggableChoice(choiceID: 3, choiceText: "jawaban C"),
        DraggableChoice(choiceID: 4, choiceText: "jawaban D")
    ]
    @State private var droppedAnswer: DraggableChoice = DraggableChoice(choiceID: 4, choiceText: "jawaban D")
    var body: some View {
        Text("Fill In The Blank")
        
        HStack{
            VStack {
               Text("Judul")
                Spacer()
                ZStack{
                    Text(droppedAnswer.choiceText)
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 200, height: 100)
                        .foregroundColor(Color(.secondarySystemFill))
                        .dropDestination(for: DraggableChoice.self) { droppedChoice, location in
                            let previouslySelectedChoice = droppedAnswer
                            droppedAnswer = droppedChoice[0]
                            return true
                        }
                }
            }
            .frame(maxWidth: .infinity)
            Spacer(minLength: 20)
            ChoicePoolView(choices: choices)
            .frame(maxWidth: .infinity)
        }
        .padding(50)
        
    }
}

#Preview {
    QuizFillBlankView()
}
