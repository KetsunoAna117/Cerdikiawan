//
//  DroppableBox.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 20/06/24.
//

import SwiftUI

struct DroppableBox: View {
    @ObservedObject var fillBlankVM: QuizFillBlankViewModel
    @State var boxText: String
    
    var index: Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 150, height: 40)
                .foregroundColor(Color(.secondarySystemFill))
            if boxText != "" {
                Button3D(text: boxText, color: Color.cerdikiawanOrange)
            }
            
        }
        .dropDestination(for: DraggableChoice.self) { droppedChoice, location in
            // handle drop logic here
            if let choice = droppedChoice.first {
                fillBlankVM.handleChoiceDrop(
                    index: index,
                    droppedChoice: choice
                )
                self.boxText = droppedChoice[0].choiceDescription
            }
            return true // for a successful drop
        }
        .onTapGesture {
            if fillBlankVM.droppedAnswer[index] != nil {
                fillBlankVM.handleRemoveChoice(index: index)
                self.boxText = ""
            }
        }
        
    }
}

#Preview {
    DroppableBox(
        fillBlankVM: QuizFillBlankViewModel(
            questions: QuizModelData().rumpang4[0].quizStory,
            choices: QuizModelData().rumpang4[0].quizChoiceList.map {DraggableChoice(choiceID: $0.choiceId, choiceText: $0.choiceDescription)}),
        boxText: "",
        index: 0
    )
}
