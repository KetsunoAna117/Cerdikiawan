//
//  QuizMultiChoiceView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct QuizMultiChoiceView: View {
    @State var selectedAnswer = -1 // 0 - 3
    
    @State var choices = [
        DraggableChoice(choiceID: 1, choiceText: "jawaban A"),
        DraggableChoice(choiceID: 2, choiceText: "jawaban B"),
        DraggableChoice(choiceID: 3, choiceText: "jawaban C"),
        DraggableChoice(choiceID: 4, choiceText: "jawaban D")
    ]
    
    var body: some View {
        HStack{
            VStack{
                Text("KOCHENG")
                    .padding([.bottom], 20)
                Image("placeholderPhoto")
                    .padding([.bottom], 50)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            }
            .frame(maxWidth: .infinity)
            Spacer(minLength: 20)
            VStack(alignment: .leading, spacing: 20){
                Text("Some questions blablablablablablablabbla?")
                
                
                ForEach(choices) { choice in
                    AnswerButton(isClicked: choice.choiceID == selectedAnswer, choice: choice)
                        .onTapGesture {
                            selectedAnswer = choice.choiceID
                        }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(50)
    }
}

#Preview {
    QuizMultiChoiceView()
}
