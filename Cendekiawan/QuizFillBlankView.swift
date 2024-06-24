//
//  QuizFillBlankView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct QuizFillBlankView: View {
    @ObservedObject var vm: QuizFillBlankViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            VStack() {
                Image("placeholderPhoto")
                    .padding(.bottom, 30)
                GeometryReader { geometry in
                    renderTextWithPlaceHolders(availableWidth: 400)
                        .frame(width: 400)
                }
            }
            
            VStack (alignment: .center) {
                Text("Isilah paragraf disamping dengan kata yang tepat")
                    .font(.title3)
                    .fontWeight(.bold)
                
                VStack(alignment: .trailing) {
                    ChoicePoolView(choices: vm.choices, width: 400)
                    Button(action: {
                        
                    }, label: {
                        Text("Periksa")
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                }
            }
        }
        .padding(.horizontal, 50)
    }
    
    func renderTextWithPlaceHolders(availableWidth: CGFloat) -> some View{
        let parts = vm.questions.components(separatedBy: "___")
        var views: [AnyView] = []
        
        for index in parts.indices {
            views.append(AnyView(
                Text(parts[index])
                    .font(.body)
            ))
            
            if index < parts.indices.last! {
                // this will append rectangle to the paragraph
                views.append(AnyView(
                    DroppableBox(boxText: vm.droppedAnswer.isEmpty ? "" : vm.droppedAnswer[index].choiceText)
                        .dropDestination(for: DraggableChoice.self, action: { droppedChoice, location in
                            vm.handleChoiceDrop(index: index, droppedChoice: droppedChoice)
                            return true
                        })
                        .onTapGesture {
                            vm.removeChoicesFromAnswer(index: index)
                        }
                ))
            }
        }
        
        return VStack {
            FlexibleView(availableWidth: availableWidth, views: views)
        }
    }
}

#Preview {
    QuizFillBlankView(
        vm: QuizFillBlankViewModel(
            questions: "Apa yang dicari orang ___? Bintang ___. Tanpa itu, kita mempunyai ___ dan tidak akan mendapatkan ___",
            choices: [
                Choice(choiceID: 1, choiceText: "Sigma"),
                Choice(choiceID: 2, choiceText: "Skibidi"),
                Choice(choiceID: 3, choiceText: "L Rizz"),
                Choice(choiceID: 4, choiceText: "Gyatt")
            ]
        )
    )
}
