//
//  QuizMatchingWordView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 20/06/24.
//

import SwiftUI

struct QuizMatchingWordView: View {
    @Binding var choiceLeft: [Choice]
    @Binding var choiceRight: [Choice]
    
    @StateObject private var vm: QuizMatchingWordViewModel = QuizMatchingWordViewModel()
    
    var body: some View {
        VStack() {
            HStack {
                Rectangle()
                    .frame(width: 23, height: 23)
                .foregroundStyle(Color.gray)
                Text("Memasangkan teks hasil idiom")
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 50) {
                    ForEach(choiceLeft) { choice in
                        ZStack {
                            Rectangle()
                                .frame(width: 155, height: 75)
                                .foregroundStyle(
                                    vm.boxShouldActive(choiceID: choice.choiceID, selectedFrom: "Left") ? Color.blue : Color.gray)
                            Text(choice.choiceText)
                                .padding(.vertical, 4)
                                .lineLimit(2)
                        }
                        .onTapGesture {
                            vm.handleSelection(choiceId: choice.choiceID, selectedFrom: "Left")
                        }
                        .frame(maxWidth: 155, maxHeight: 75)
                    }
                }
                Spacer()
                VStack(alignment: .leading, spacing: 50) {
                    ForEach(choiceRight) { choice in
                        ZStack {
                            Rectangle()
                                .frame(width: 155, height: 75)
                                .foregroundStyle(
                                    vm.boxShouldActive(choiceID: choice.choiceID, selectedFrom: "Right") ? Color.blue : Color.gray)
                            Text(choice.choiceText)
                                .padding(.vertical, 4)
                                .lineLimit(2)
                        }
                        .frame(maxWidth: 155, maxHeight: 75)
                        .onTapGesture {
                            vm.handleSelection(choiceId: choice.choiceID, selectedFrom: "Right")
                        }
                    }
                }
            }
            .padding(.top, 50)
            .frame(maxWidth: 700, alignment: .center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay {
            
            LineConnectionView(connections: vm.getAllConnections(choiceLeft: choiceLeft, choiceRight: choiceRight))
        }
    }
}

#Preview {
    NavigationStack {
        QuizMatchingWordView(
            choiceLeft: .constant([
                Choice(choiceID: 1, choiceText: "Rendah Hati"),
                Choice(choiceID: 2, choiceText: "Gulung Tikar"),
                Choice(choiceID: 3, choiceText: "Naik Daun"),
                Choice(choiceID: 4, choiceText: "Naik Daun"),
                Choice(choiceID: 5, choiceText: "Naik Daun"),
            ]),
            choiceRight: .constant([
                Choice(choiceID: 1, choiceText: "Tidak Sombong"),
                Choice(choiceID: 2, choiceText: "Terkenal"),
                Choice(choiceID: 3, choiceText: "Bangkrut"),
                Choice(choiceID: 4, choiceText: "Naik Daun"),
                Choice(choiceID: 5, choiceText: "Naik Daun"),
            ])
        )
    }
}
