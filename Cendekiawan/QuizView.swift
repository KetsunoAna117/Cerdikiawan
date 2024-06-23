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
                        Choice(choiceId: 1, choiceDescription: "Rendah Hati"),
                        Choice(choiceId: 2, choiceDescription: "Gulung Tikar"),
                        Choice(choiceId: 3, choiceDescription: "Naik Daun"),
                    ]),
                    choiceRight: .constant([
                        Choice(choiceId: 1, choiceDescription: "Tidak Sombong"),
                        Choice(choiceId: 2, choiceDescription: "Terkenal"),
                        Choice(choiceId: 3, choiceDescription: "Bangkrut"),
                    ]),
                    question: "Memasangkan teks hasil idiom"
                    )
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
            .environment(QuizModelData())
    }
}
