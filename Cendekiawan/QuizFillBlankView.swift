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
                        LazyVGrid(columns: adaptipveColumns, content: {
                            ForEach(0..<vm.questions.count, id: \.self) { index in
                                if vm.questions[index] == "_" {
                                    Text("Deez Nuts")
//                                    DroppableBox(fillBlankVM: vm, index: index)
                                }
                                else {
                                    Text(vm.questions[index])
                                        .padding(.vertical, 4)
                                }
                            }
                        })
                    }
                }
                .frame(width: geometry.size.width * 0.6)
                
                // Right side
                VStack(alignment: .trailing) {
                    ChoicePoolView(choices: vm.choices, width: 400)
                    Spacer()
                    Button3D(text: "Lanjut", color: Color.cerdikiawanOrange)
                        .padding()
                }
                .background(Color.cerdikiawanYellowMuda)
                .frame(width: geometry.size.width * 0.4)
            }
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



