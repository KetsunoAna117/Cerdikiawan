//
//  QuizWordBlank.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 20/06/24.
//

import SwiftUI

struct QuizWordBlankView: View {
    @ObservedObject var vm: QuizWordBlankViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 200))
    ]
    
    var body: some View {
        VStack {
            Text("Pesan yang disampaikan oleh penulis dalam cerita disebut...")
                .font(.body)
                .padding([.bottom], 30)
            Image("placeholderPhoto")
            Spacer()
            HStack (alignment: .center, spacing: 50) {
                ForEach (0..<vm.guessedWord.count, id: \.self) { index in
                    VStack {
                        if vm.guessedWord[index].choiceID != -1 {
                            Text(vm.guessedWord[index].choiceText)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }else {
                            Text(" ")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                        }
                        Text("_____")
                    }
                    .onTapGesture {
                        vm.removeCharacterFromAnswer(index: index)
                    }
                }
            }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .padding([.horizontal], 30)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4)
                    .foregroundColor(Color(.secondarySystemFill))
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach (vm.choices, id: \.choiceID) { choosed in
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 128, height: 34)
                                .foregroundStyle(Color(.lightGray))
                            Text(choosed.choiceText)
                                .font(.headline)
                        }
                        .onTapGesture {
                            vm.addCharacterToAnswer(choosed: choosed)
                        }
                    }
                }.padding(30)
            }
            
            
        }
        .padding(50)
        .onAppear{
            vm.setupQuestion()
        }
    }
}

#Preview {
    QuizWordBlankView(
        vm: QuizWordBlankViewModel(
            choices: [
                Choice(choiceID: 0, choiceText: "A"),
                Choice(choiceID: 1, choiceText: "A"),
                Choice(choiceID: 2, choiceText: "M"),
                Choice(choiceID: 3, choiceText: "I"),
                Choice(choiceID: 4, choiceText: "H"),
                Choice(choiceID: 5, choiceText: "N"),
                Choice(choiceID: 6, choiceText: "E"),
                Choice(choiceID: 7, choiceText: "R"),
                Choice(choiceID: 8, choiceText: "T"),
                Choice(choiceID: 9, choiceText: "A")],
            numberOfLetter: 6
        )
    )
}


