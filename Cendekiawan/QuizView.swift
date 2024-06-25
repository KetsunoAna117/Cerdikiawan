//
//  QuizView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 20/06/24.
//

import SwiftUI

struct QuizView: View {
    @State private var quizTitle: String = "Pasang Kata"
    @Environment(QuizModelData.self) private var modelData
    
    var body: some View {
        VStack {
            HStack{
                Button{
                    //TODO: Back Button
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.gray)
                }
                ProgressView(value: 2, total: 5)
                        .padding([.horizontal], 52)
            }.padding([.horizontal], 30)
            GeometryReader(content: { geometry in
                VStack {
                    // the content of the quiz should go here
//                    QuizWordBlankView()
//                    QuizMatchingWordView(vm: <#QuizMatchingWordViewModel#>)
                }
                
            })
        }
        .padding([.top], 16)
        
    }
}

#Preview {
    NavigationStack {
        QuizView()
            .environment(QuizModelData())
    }
}
