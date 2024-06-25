//
//  QuizFillBlankView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct QuizFillBlankView: View {
    @Environment(QuizModelData.self) private var modelData
    @ObservedObject var vm: QuizFillBlankViewModel
    
    private let adaptipveColumns = [
        GridItem(.adaptive(minimum: 150, maximum: .infinity))
    ]
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                // Left side
                VStack {
                    ScrollView {
                        Image("placeholderPhoto")
                            .padding(.bottom, 40)
                        VStack {
                            renderTextWithPlaceHolders(availableWidth: geometry.size.width * 0.5)
                        }
                    }
                }
                .frame(width: geometry.size.width * 0.6)
                
                // Right side
                VStack(alignment: .trailing) {
                    ChoicePoolView(choices: $vm.choices, width: 400)
                    Spacer()
                    Button3D(text: "Lanjut", color: Color.cerdikiawanOrange)
                        .padding()
                }
                .background(Color.cerdikiawanYellowMuda)
                .frame(width: geometry.size.width * 0.4)
            }
        }

    }
    
    func renderTextWithPlaceHolders(availableWidth: CGFloat) -> some View {
        var order = 0 // to store the index of the droppable
        
        let parts = vm.questions.split(separator: " ")
        var views: [AnyView] = []
        
        for index in parts.indices {
            if parts[index] == "_" {
                views.append(AnyView(
                    DroppableBox(fillBlankVM: vm, index: order)
                ))
                order += 1 // increment droppable index after being added
            }
            else {
                views.append(AnyView(
                    Text(parts[index])
                        .font(.body)
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
            questions: QuizModelData().rumpang4[0].quizStory,
            choices: QuizModelData().rumpang4[0].quizChoiceList
        )
    )
    .environment(QuizModelData())
}



