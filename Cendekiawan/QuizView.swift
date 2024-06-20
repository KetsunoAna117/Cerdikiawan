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
                Rectangle()
                    .foregroundStyle(Color(red: 0.5, green: 0.76, blue: 0.93))
                    .frame(width: geometry.size.width - 50, height: 20)
                    .position(x: geometry.size.width / 2)
                    .padding(.vertical, 16)
                
                VStack {
                    // the content of the quiz should go here
//                    QuizMatchingWordView()
                }
                
            })
        }
        .navigationTitle(quizTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    // Back button
                }, label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.blue)
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
