//
//  ContentView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HomeView()
        }
        .padding()
    }
}

//ini tadi buat testing user level
//@StateObject private var user = User(name: "Test1")
//
//Text("Name: \(user.name)")
//Text("Level: \(user.levelStorage.value)")
//Text("Exp: \(user.exp)/\(user.levelStorage.boundaries)")
//
//Button("Gain Experience") {
//    user.exp += 10
//}

//ini tadi buat coba quizData
//@Environment(QuizViewModel.self) var quizModelData
//var testShowData: [StoreQuizData] {
//    quizModelData.listQuizQuestion
//}
//            List{
//                ForEach(quizModelData.listQuizQuestion, id: \.quizId) { quizData in
//                    Text(quizData.quizCategory)
//                }
//            }


#Preview {
    ContentView().environment(QuizViewModel())
}
