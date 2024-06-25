//
//  ChoicePoolView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct ChoicePoolView: View {
    let choices: [Choice]
    let width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack (alignment: .top){
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: width, height: 300)
                    .foregroundColor(Color(.secondarySystemFill))
                
                VStack(alignment: .leading, spacing: 12) {
                    renderChoicesToChoicePool(availableWidth: width - 20)
                }
                .padding(.vertical, 30)
            }
        }
    }
    
    func renderChoicesToChoicePool(availableWidth: CGFloat) -> some View{
        var views: [AnyView] = []
        
        for choice in choices {
            views.append(AnyView(
                Text(choice.choiceDescription)
                    .padding(12)
                    .background(Color(uiColor: .secondarySystemGroupedBackground))
                    .cornerRadius(5)
                    .shadow(radius: 1, x: 1, y: 1)
            ))
        }
        
        return VStack {
            FlexibleView(availableWidth: availableWidth, views: views)
        }
    }
}

#Preview {
    ChoicePoolView(choices: [DraggableChoice(choiceID: 1, choiceText: "jawaban A"),
                             DraggableChoice(choiceID: 2, choiceText: "jawaban B"),
                             DraggableChoice(choiceID: 3, choiceText: "jawaban C"),
                             DraggableChoice(choiceID: 4, choiceText: "jawaban D")
                            ], width: 400)
}
