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
    
    var points:[String] = [
        "A",
        "B",
        "C",
        "D",
        "E",
    ]
    var body: some View {
        HStack {
            Text("\(points[choice.choiceId]). ")
            Text(choice.choiceDescription)
        }
        .foregroundStyle(isClicked ? .red: .black)
        .padding(10)
        .border(Color.cerdikiawanBlack, width: 3)
    }
}

#Preview {
    AnswerButton(isClicked: true, choice: Choice(choiceId: 1, choiceDescription: "Answer A"))
}
