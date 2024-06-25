//
//  ViewA.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 25/06/24.
//

import SwiftUI

struct TestViewMultiChoice: View {
    @ObservedObject var vm: QuizMultipleChoiceViewModel
    @ObservedObject var vm2: QuizViewModel
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all) // Extend the background color to the edges of the screen
            VStack {
                Text("MultiChoice")
                    .foregroundColor(.white)
                Text("Id: \(vm2.currentQuiz)")
                    .foregroundColor(.white)
            }
            
        }
        .overlay{
            VStack{
                Spacer()
                BottomConfirmOverlayView(isCorrect: false, description: "", button: Button3D(text: "Periksa", color: Color.cerdikiawanGreyMid), action: {
                    vm.isChecked = true
                    vm2.startGameplay()
                })
            }
        }
    }
}

#Preview {
    TestViewMultiChoice(vm: QuizMultipleChoiceViewModel(), vm2: QuizViewModel(nextQuiz: (quizModel: "MultipleChoice", tipeQuiz: "idePopkok")))
}