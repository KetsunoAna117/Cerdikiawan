//
//  AnswerButton.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct AnswerButton: View {
    var boxColor: Color
    var choice: Choice
    
    var points:[String] = [
        "A",
        "B",
        "C",
        "D",
        "E",
    ]
    var body: some View {
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(boxColor)
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.cerdikiawanGreyMid.opacity(0.5), lineWidth: 3)
                .shadow(
                    radius: boxColor != Color.cerdikiawanWhite ? 3 : 0,
                    y: boxColor != Color.cerdikiawanWhite ? -4 : 0
                )
            HStack {
                Text("\(points[choice.choiceId]). ")
                Text(choice.choiceDescription)
            }
            .font(.body)
            .foregroundStyle(boxColor == Color.cerdikiawanWhite || boxColor == Color.cerdikiawanYellow ? Color.cerdikiawanBlack : Color.cerdikiawanWhite)
            .padding(12)
        }
        .frame(width: 392, height: 87)
    }
}

#Preview {
    VStack{
        AnswerButton(boxColor: Color.cerdikiawanWhite, choice: Choice(choiceId: 1, choiceDescription: "Answer A"))
        AnswerButton(boxColor: Color.cerdikiawanYellow, choice: Choice(choiceId: 1, choiceDescription: "Answer A"))
        AnswerButton(boxColor: Color.cerdikiawanGreenTua, choice: Choice(choiceId: 1, choiceDescription: "Answer A"))
        AnswerButton(boxColor: Color.cerdikiawanRed, choice: Choice(choiceId: 1, choiceDescription: "Answer A"))
    }
}
