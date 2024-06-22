//
//  QuizWordBlank.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 20/06/24.
//

import SwiftUI

struct QuizWordBlankView: View {
    @State var choices = [
        Choice(choiceID: 0, choiceText: "A"),
        Choice(choiceID: 1, choiceText: "A"),
        Choice(choiceID: 2, choiceText: "M"),
        Choice(choiceID: 3, choiceText: "I"),
        Choice(choiceID: 4, choiceText: "H"),
        Choice(choiceID: 5, choiceText: "N"),
        Choice(choiceID: 6, choiceText: "E"),
        Choice(choiceID: 7, choiceText: "R"),
        Choice(choiceID: 8, choiceText: "T"),
        Choice(choiceID: 9, choiceText: "A")
    ]
    @State var numberOfLetter: Int = 6
    @State var guessedWord: [Choice] = []
    @State var nextInputFlag = 0
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
                ForEach (0..<guessedWord.count, id: \.self) { index in
                    VStack {
                        if guessedWord[index].choiceID != -1 {
                            Text(guessedWord[index].choiceText)
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
                        if guessedWord[index].choiceID != -1 {
                            choices.append(guessedWord[index])
                            guessedWord[index] = Choice(choiceID: -1, choiceText: "")
                            nextInputFlag = checkNextEmptyIndex(substring: guessedWord)
                        }
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
                    ForEach (choices, id: \.choiceID) { choosed in
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 128, height: 34)
                                .foregroundStyle(Color(.lightGray))
                            Text(choosed.choiceText)
                                .font(.headline)
                        }
                        .onTapGesture {
                            if nextInputFlag < guessedWord.count {
                                choices.removeAll { $0.choiceID == choosed.choiceID }
                                guessedWord[nextInputFlag] = choosed
                                nextInputFlag =  checkNextEmptyIndex(substring: guessedWord)
                            }
                        }
                    }
                }.padding(30)
            }
            
            
        }
        .padding(50)
        .onAppear{
            if guessedWord.isEmpty {
                guessedWord = Array(repeating: Choice(choiceID: -1, choiceText: ""), count: numberOfLetter)
            }
        }
    }
}

#Preview {
    QuizWordBlankView()
}

func checkNextEmptyIndex(substring: [Choice]) -> Int {
    var nextInputFlag = 0
    if let nextIndex = substring.firstIndex(where: { $0.choiceID == -1 }) {
        nextInputFlag = nextIndex
    } else {
        nextInputFlag = substring.count
    }
    return nextInputFlag
}
