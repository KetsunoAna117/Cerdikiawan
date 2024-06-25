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
            ZStack {
                Image("HomeLemari")
                    .resizable()
                VStack{
                    HStack {
                        LevelBadgeView(level: 1)
                        ExpProgressView(progress: 0.5)
                        Spacer()
                    }
                    .padding([.leading], 63)
                    Spacer()
                    Image("Aminah")
                        .resizable()
                        .frame(width: 136, height: 359)
                        .padding([.bottom], 42)
                    SubmitButton(text: "Mulai", color: Color.cerdikiawanBlueMid)
                        .padding([.bottom], 45)
                }
                .padding([.top], 34)
            }
            .ignoresSafeArea()
        }
    }
    
    
}

#Preview {
    HomeView()
        .environment(QuizModelData())
}
