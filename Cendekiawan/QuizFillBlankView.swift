//
//  QuizFillBlankView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct QuizFillBlankView: View {
    @ObservedObject var vm: QuizFillBlankViewModel
    
//    init() {
////        for _ in 0..<(trunc.count - 1) {
////            print("added")
////            droppedAnswer.append(DraggableChoice(choiceID: 0, choiceText: ""))
////            print(droppedAnswer)
////        }
//    }
    
    var body: some View {
        HStack{
            ScrollView {
                VStack {
                   Text("Judul")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding([.bottom], 30)
                    Spacer()
                    Image("placeholderPhoto")
                        .padding([.bottom], 30)
                    Spacer()
                    VStack(alignment: .leading) {
                        ForEach (0..<vm.trunc.count, id: \.self) { index in
                            HStack(alignment: .center){
                                Text(vm.trunc[index])
                                if index < vm.trunc.count - 1{
                                    Spacer()
                                    DroppableBox(boxText: vm.droppedAnswer.isEmpty ? "" : vm.droppedAnswer[index].choiceText)
                                        .dropDestination(for: DraggableChoice.self) { droppedChoice, location in
                                            print(index)
                                            vm.handleChoiceDrop(index: index, droppedChoice: droppedChoice)
                                            return true
                                        }
                                        .onTapGesture {
                                            vm.removeChoicesFromAnswer(index: index)
                                        }
                                }
                                
                            }
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            Spacer(minLength: 20)
            VStack{
                Text("Masukkan kata yang tepat untuk setiap kata yang rumpang dalam teks!")
                    .font(.title3)
                    .fontWeight(.bold)
                ChoicePoolView(choices: vm.choices)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(50)
        .onAppear {
            vm.setupQuestion()
        }
        
    }
}

#Preview {
    QuizFillBlankView(
        vm: QuizFillBlankViewModel(
            questions: "Apa yang dicari orang __________? Bintang __________. Kita Tanpa itu, kita mempunyai __________ dan tidak akan mendapatkan __________",
            choices: [
                Choice(choiceID: 1, choiceText: "Sigma"),
                Choice(choiceID: 2, choiceText: "Skibidi"),
                Choice(choiceID: 3, choiceText: "L Rizz"),
                Choice(choiceID: 4, choiceText: "Gyatt")
            ]
        )
    )
}
