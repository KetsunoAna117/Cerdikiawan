//
//  ChoicePoolView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct ChoicePoolView: View {
    let choices: [DraggableChoice]
    var body: some View {
        VStack(alignment: .leading) {
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(.secondarySystemFill))
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(choices, id: \.uniqueId) { choice in
                        Text(choice.choiceDescription)
                            .padding(12)
                            .background(Color(uiColor: .secondarySystemGroupedBackground))
                            .cornerRadius(8)
                            .shadow(radius: 1, x: 1, y: 1)
                            .draggable(choice)
                    }
                }
            }
        }
    }
}

#Preview {
    ChoicePoolView(choices: [DraggableChoice(choiceID: 1, choiceText: "jawaban A"),
                             DraggableChoice(choiceID: 2, choiceText: "jawaban B"),
                             DraggableChoice(choiceID: 3, choiceText: "jawaban C"),
                             DraggableChoice(choiceID: 4, choiceText: "jawaban D")
        ])
}
