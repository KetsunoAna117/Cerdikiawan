//
//  AnswerButton.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct AnswerButton: View {
    var isClicked: Bool
    var choice: Choice
    var body: some View {
        Text(choice.choiceText)
            .foregroundStyle(isClicked ? .red: .black)
            .font(.title3)
            .padding(10)
            .border(Color.black, width: 3)
    }
}

#Preview {
    AnswerButton(isClicked: true, choice: Choice(choiceID: 1, choiceText: "Answer A"))
}
