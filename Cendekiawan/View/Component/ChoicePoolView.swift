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
    ChoicePoolView(choices: [DraggableChoice(choiceId: 1, choiceDescription: "Pilihan 1"),
        DraggableChoice(choiceId: 2, choiceDescription: "Pilihan 2"),
        DraggableChoice(choiceId: 3, choiceDescription: "Pilihan 3"),
        ])
}
