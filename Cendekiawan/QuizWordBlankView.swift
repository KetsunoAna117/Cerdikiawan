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
        GridItem(.adaptive(minimum: 48))
    ]
    
    var body: some View {
        VStack {
            Text("Pesan yang disampaikan oleh penulis dalam cerita disebut...")
                .font(.body)
                .fontWeight(.bold)
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
                            .fill(Color.white)
                            .frame(width: 437, height: 155)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.greyMid, lineWidth: 1)
                            )
                            .padding([.horizontal], 30)
                LazyVGrid(columns: columns, spacing: 32) {
                    ForEach (vm.choices, id: \.choiceID) { choosed in
                        ZStack{
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 50, height: 33)
                                .foregroundStyle(Color(.blue))
                            Text(choosed.choiceText)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .onTapGesture {
                            vm.addCharacterToAnswer(choosed: choosed)
                        }
                    }
                }.frame(width: 300, height: 155)
                .padding(30)
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


