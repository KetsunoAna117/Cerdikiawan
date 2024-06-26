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
    
    @State private var isAllFieldFilled: Bool = false
    @State private var isAnswerChecked: Bool = false
    
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
                    VStack(alignment: .leading) {
                        ChoicePoolView(fillBlankVM: vm ,choices: $vm.choicesPool, width: 400)
                        
                        // Feedback
                        if isAnswerChecked {
                            VStack(alignment: .leading) {
                                if $vm.listWrongAnswerId.count <= 0 {
                                    Text("Horee! Jawaban kamu benar!")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.cerdikiawanGreenTua)
                                }
                                else {
                                    Text("Yuk, cek artinya terlebih dahulu")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                // feedback view
                                VStack(alignment: .leading) {
                                    ForEach(Utils.splitTextIntoPairs(text: vm.model.quizFeedback.feedbackDescription), id: \.0) { pair in
                                        HStack{
                                            Text("\(pair.0)")
                                                .fontWeight(.bold)
                                                .frame(width: 150, alignment: .leading)
                                            Text("=")
                                            Text("\(pair.1)")
                                        }
                                        .padding(.bottom, 10)
//                                        .overlay{
//                                            RoundedRectangle(cornerRadius: 2)
//                                                .inset(by: 1.5)
//                                                .stroke(Color.cerdikiawanGreyMid, lineWidth: 1)
//                                        }
                                    }
                                        
                                }
                                
                            }
                            .padding(.horizontal, 30)
                        }
                    }

                    Spacer()
                    
                    if isAnswerChecked == false {
                        Button3D(text: "Periksa", color: isAllFieldFilled ? Color.cerdikiawanOrange : Color.cerdikiawanGreyMid)
                            .padding()
                            .disabled(!isAllFieldFilled)
                            .onTapGesture {
                                // check answer logic at viewModel if all field has been filled
                                if isAllFieldFilled {
                                    vm.checkAnswer()
                                    isAnswerChecked = true
                                }
                            }
                    }
                    else {
                        Button3D(text: "Lanjut", color: Color.cerdikiawanOrange)
                            .padding()
                            .onTapGesture {
                                // logic for lanjut here
                            }
                    }

                }
                .background(Color.cerdikiawanYellowMuda)
                .frame(width: geometry.size.width * 0.4)
                .onChange(of: vm.isFieldFilled) { oldValue, newValue in
                    // listen for change from viewModel
                    isAllFieldFilled = newValue
                }
            }
        }

    }
    
    func renderTextWithPlaceHolders(availableWidth: CGFloat) -> some View {
        var order = 0 // to store the index of the droppable
        
        let parts = vm.model.quizStory.split(separator: " ")
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
            quizFillBlankModel: QuizModelData().rumpang4[0]
        )
    )
    .environment(QuizModelData())
}



