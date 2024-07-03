//
//  DroppableBox.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 20/06/24.
//

import SwiftUI

struct DroppableBox: View {
    @ObservedObject var fillBlankVM: QuizFillBlankViewModel
    @State var boxText: String = ""
    
    @State var isAnswerChecked: Bool = false
    @State var buttonColor: DroppableButtonState = DroppableButtonState.unchecked
    
    var index: Int
    
    enum DroppableButtonState {
        case unchecked
        case correct
        case wrong
        
        var color: Color {
            switch self {
            case .unchecked:
                Color.cerdikiawanOrange
            case .correct:
                Color.cerdikiawanGreenTua
            case .wrong:
                Color.cerdikiawanRed
            }
        }
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 150, height: 40)
                .foregroundColor(Color(.secondarySystemFill))
            if boxText != "" {
                Button3D(text: boxText, color: buttonColor.color)
//                    .draggable(fillBlankVM.droppedAnswer[index]!) // make it so it can be dragable (have to conform transferable protocol)
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
            // enable redo if the user haven't check
            if fillBlankVM.checkAnswerEvent == false {
                if fillBlankVM.droppedAnswer[index] != nil {
                    fillBlankVM.handleRemoveChoice(index: index)
                    self.boxText = ""
                }
            }
        }
        // this will run if there's a change in droppedAnswer
        .onChange(of: fillBlankVM.droppedAnswer.count, { oldValue, newValue in
            if let answer = fillBlankVM.droppedAnswer[index] {
                self.boxText = answer.choiceDescription
            }
        })
        // this will run if user check the answer
        .onChange(of: fillBlankVM.checkAnswerEvent) { oldValue, newValue in
            self.isAnswerChecked = newValue
            if fillBlankVM.listCorrectAnswerId.contains(index) {
                buttonColor = DroppableButtonState.correct
            }
            else if fillBlankVM.listWrongAnswerId.contains(index){
                buttonColor = DroppableButtonState.wrong
            }
        }
        
    }
}

#Preview {
    DroppableBox(
        fillBlankVM: QuizFillBlankViewModel(
            quizFillBlankModel: QuizModelData().rumpang4[0]
            ),
        boxText: "",
        index: 0
    )
}
