//
//  QuizView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 20/06/24.
//

import SwiftUI

struct QuizView: View {
    @State private var quizTitle: String = "Pasang Kata"
    
    var body: some View {
        VStack {
            GeometryReader(content: { geometry in
            ProgressView(value: 2, total: 5)
                    .padding([.horizontal], 52)
                VStack {
                    // the content of the quiz should go here
//                    QuizWordBlankView()
                    QuizMatchingWordView(choiceLeft: .constant([
                        Choice(choiceID: 1, choiceText: "Rendah Hati"),
                        Choice(choiceID: 2, choiceText: "Gulung Tikar"),
                        Choice(choiceID: 3, choiceText: "Naik Daun"),
                    ]),
                    choiceRight: .constant([
                        Choice(choiceID: 1, choiceText: "Tidak Sombong"),
                        Choice(choiceID: 2, choiceText: "Terkenal"),
                        Choice(choiceID: 3, choiceText: "Bangkrut"),
                    ]))
                }
                
            })
        }
        .padding([.top], 16)
        .navigationTitle(quizTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    // Back button
                }, label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.secondary)
                })
            }
        })
    }
}

#Preview {
    NavigationStack {
        QuizView()
    }
}
