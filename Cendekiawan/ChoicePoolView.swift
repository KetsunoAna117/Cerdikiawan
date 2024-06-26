//
//  ChoicePoolView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct ChoicePoolView: View {
    @Binding var choices: [DraggableChoice]
    let width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pasangkan kata dibawah ini ke paragraf disamping dengan tepat!")
                .font(.title3)
                .fontWeight(.bold)
                .frame(width: width, alignment: .leading)
            VStack {
                renderChoicesToChoicePool(availableWidth: width - 20)
            }
            .frame(height: 180, alignment: .top)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .inset(by: 1.5)
                    .stroke(Color.cerdikiawanGreyMid, lineWidth: 5)
                
            )
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
        choices: .constant(
            QuizModelData().rumpang4[0].quizChoiceList.map {DraggableChoice(choiceID: $0.choiceId, choiceText: $0.choiceDescription)}
        ),
        width: 400
    )
}
