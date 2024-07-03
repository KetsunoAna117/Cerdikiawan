//
//  HomeView.swift
//  Cendekiawan
//
//  Created by Roland Ramadan on 23/06/24.
//

import SwiftUI

//TODO: PENTING next soal masih bisa kepilih 2 kali
struct HomeView: View {
    @Environment(QuizModelData.self) private var modelData
    
    //2 line of code below is for connecting to gameplay purposes
    @ObservedObject var vm: QuizViewModel = QuizViewModel(nextQuiz: ("MultiChoice", "implisit"))
    @State private var isDirected = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("HomeBase")
                    .resizable()
                VStack{
                    HStack {
                        LevelBadgeView(level: vm.user.levelStorage.value)
                        ExpProgressView(progress: CGFloat(vm.user.exp)/CGFloat(vm.user.levelStorage.boundaries))
                        Spacer()
                    }
                    .padding([.leading], 63)
                    Spacer()
                    HStack(alignment: .bottom) {
                        Image("AvatarDefaultBoy")
                            .resizable()
                            .frame(width: 134, height: 353)
                            .padding(.trailing, 200)
                        .padding([.bottom], 42)
                        BookshelfView(userLevel: vm.user.levelStorage.value)
                    }
                    .padding(.trailing, 63)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Button {
                        vm.valueProgressBar = 0
                        vm.quizExperienceGain = 0
                        isDirected = true
                        vm.startGameplay()
                    } label: {
                        SubmitButton(text: "Mulai", color: Color.cerdikiawanBlueMid)
                            .padding([.bottom], 45)
                    }
                }
                .padding([.top], 34)
            }
            .ignoresSafeArea()
            .navigationDestination(isPresented: $isDirected) {
                QuizView(vm: vm, rootIsActive: $isDirected)
                    .environment(modelData)
            }
        }
    }
    
    
}

#Preview {
    HomeView()
        .environment(QuizModelData())
}
