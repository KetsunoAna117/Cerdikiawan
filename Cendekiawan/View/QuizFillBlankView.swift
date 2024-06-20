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
        DraggableChoice(choiceId: 1, choiceDescription: "Pilihan 1"),
        DraggableChoice(choiceId: 2, choiceDescription: "Pilihan 2"),
        DraggableChoice(choiceId: 3, choiceDescription: "Pilihan 3")
    ]
    @State private var droppedAnswer: DraggableChoice = DraggableChoice(choiceId: 0, choiceDescription: "")
    var body: some View {
        Text("Fill In The Blank")
        
        HStack{
            VStack {
               Text("Judul")
                Spacer()
                ZStack{
                    Text(droppedAnswer.choiceDescription)
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
