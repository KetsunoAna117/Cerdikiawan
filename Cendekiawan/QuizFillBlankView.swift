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
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                // Left side
                VStack {
                    ScrollView {
                        Image("placeholderPhoto")
                            .padding(.bottom, 40)
                        VStack {
                            // The question goes here
                        }
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



