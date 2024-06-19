//
//  QuizMultiChoiceView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct QuizMultiChoiceView: View {
    @State var selectedAnswer = -1 // 0 - 3
    
    @State var choices = [Choice(choiceId: 1, choiceDescription: "jawaban A"), Choice(choiceId: 2, choiceDescription: "jawaban B"), Choice(choiceId: 3, choiceDescription: "jawaban C"), Choice(choiceId: 4, choiceDescription: "jawaban D")]
    
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
                    AnswerButton(isClicked: choice.choiceId == selectedAnswer, choice: choice)
                        .onTapGesture {
                            selectedAnswer = choice.choiceId
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

class Choice: Identifiable {
    var choiceId: Int
    var choiceDescription: String
    
    init(choiceId: Int, choiceDescription: String) {
        self.choiceId = choiceId
        self.choiceDescription = choiceDescription
    }
}
