//
//  ChoicePoolView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct ChoicePoolView: View {
    let choices: [DraggableChoice]
    let width: CGFloat
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Isilah paragraf disamping dengan kata yang tepat!")
                .font(.title3)
                .fontWeight(.bold)
            VStack {
                renderChoicesToChoicePool(availableWidth: width - 20)
            }
            .frame(height: 300, alignment: .top)
        }
        .padding(30)
        .background(Color.cerdikiawanYellowMuda)
    }
    
    func renderChoicesToChoicePool(availableWidth: CGFloat) -> some View{
        var views: [AnyView] = []
        
        for choice in choices {
            views.append(AnyView(
                Button3D(text: choice.choiceDescription, color: Color.cerdikiawanWhite)
                    .draggable(choice) // make it so it can be dragable (have to conform transferable protocol)

            ))
        }
        
        return VStack {
            FlexibleView(availableWidth: availableWidth, views: views)
        }
    }
}

#Preview {
    ChoicePoolView(
        choices: QuizModelData().rumpang4[0].quizChoiceList.map {DraggableChoice(choiceID: $0.choiceId, choiceText: $0.choiceDescription)},
        width: 400
    )
}
