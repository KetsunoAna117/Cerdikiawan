//
//  QuizFillBlankView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct QuizFillBlankView: View {
    @State var questions = "Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem __________ sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem __________ Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem __________ Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem __________ sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet"
    
    @State private var choices: [DraggableChoice] = [
        DraggableChoice(choiceID: 1, choiceText: "jawaban A"),
        DraggableChoice(choiceID: 2, choiceText: "jawaban B"),
        DraggableChoice(choiceID: 3, choiceText: "jawaban C"),
        DraggableChoice(choiceID: 4, choiceText: "jawaban D")
    ]
    @State private var droppedAnswer: [DraggableChoice] = []
    
    var trunc: [String] = []
    
    init() {
        trunc = questions.split(separator: "__________").map { String($0) }
//        for _ in 0..<(trunc.count - 1) {
//            print("added")
//            droppedAnswer.append(DraggableChoice(choiceID: 0, choiceText: ""))
//            print(droppedAnswer)
//        }
    }
    
    var body: some View {
        Text("Fill In The Blank")
        
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
                        ForEach (0..<trunc.count, id: \.self) { index in
                            HStack(alignment: .center){
                                Text(trunc[index])
                                if index < trunc.count - 1{
                                    Spacer()
                                    DroppableBox(boxText: droppedAnswer.isEmpty ? "" : droppedAnswer[index].choiceText)
                                        .dropDestination(for: DraggableChoice.self) { droppedChoice, location in
                                            print(index)
                                            let previouslySelectedChoice = droppedAnswer[index]
                                            droppedAnswer[index] = droppedChoice[0]
                                            choices.removeAll { $0.uniqueId == droppedChoice[0].uniqueId }
                                            if previouslySelectedChoice.choiceID != -1 {
                                                print(previouslySelectedChoice.choiceID)
                                                choices.append(previouslySelectedChoice)
                                            }
                                            return true
                                        }
                                        .onTapGesture {
                                            // remove choices
                                            if droppedAnswer[index].choiceID != -1 {
                                                choices.append(droppedAnswer[index])
                                                droppedAnswer[index] = DraggableChoice(choiceID: -1, choiceText: "")
                                            }
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
                ChoicePoolView(choices: choices)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(50)
        .onAppear {
            if droppedAnswer.isEmpty {
                droppedAnswer = Array(repeating: DraggableChoice(choiceID: -1, choiceText: ""), count: trunc.count - 1)
            }
        }
        
    }
}

#Preview {
    QuizFillBlankView()
}
