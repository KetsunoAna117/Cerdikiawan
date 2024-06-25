//
//  HomeView.swift
//  Cendekiawan
//
//  Created by Roland Ramadan on 23/06/24.
//

import SwiftUI

import SwiftUI

//TODO: PENTING next soal masih bisa kepilih 2 kali
struct HomeView: View {
    @StateObject private var user: User = User(name: "Test")
    @Environment(QuizModelData.self) private var modelData
    @State private var quizModel: String?
    @State private var tipeQuiz: String?
    @State var isDone: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    
                }, label: {
                    Text("Play")
                        .font(.system(size: 100))
                })
                .padding()
                .border(Color.cerdikiawanBlack)
            }
            .onAppear {
                isDone = false
            }
        }
    }
    
    
}

#Preview {
    HomeView()
        .environment(QuizModelData())
}
