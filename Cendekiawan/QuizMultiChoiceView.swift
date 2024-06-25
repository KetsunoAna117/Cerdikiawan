//
//  QuizMultiChoiceView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct QuizMultiChoiceView: View {
    @StateObject private var user: User = User(name: "Test")
    @Environment(QuizModelData.self) private var modelData
    @State private var nextQuiz: (quizModel: String, tipeQuiz: String)?
    @State private var isDone: Bool = false
    
    var tipeQuiz: String
    private var quiz: QuizMultiChoice {
        if tipeQuiz == "idePokok"{
            (modelData.getIdePokok(difficulty: user.difficultyLevel)?.randomElement())!
        } else {
            (modelData.getimplisit(difficulty: user.difficultyLevel)?.randomElement())!
        }
    }
    
    @State var selectedAnswer: Int?
    
    var body: some View {
        HStack(alignment: .top) {
                    // TODO: Increase readability: for all the view inside the vstack that involved a various of stacks, consider to create a function that represent each (function of UI) view. Create an identifiable function name and let the function recieve parameters (a data or vm that holds the information the view needs to decide its behavior). Let the padding and all view positioning value to be a configurable variable consistently maintained as a single source.
                    // aku ganti jadi scrollview
                    ScrollView {
                        Text(quiz.quizTitle)
                            .padding([.bottom], 20)
                        
                        // image name diganti jadi pake modelData
                        Image("placeholderPhoto")
                            .padding([.bottom], 50)
                        
                        // untuk formatting seperti menjorok (tab) dan enter bisa ditambahin \t dan \n di jsonnya
                        Text(quiz.quizStory)
                    }
                    .frame(maxWidth: .infinity)
                    Spacer(minLength: 20)
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Pertanyaan")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(quiz.quizQuestion)
                        
                        ForEach(quiz.quizChoiceList, id: \.choiceId) { choice in
                            AnswerButton(boxColor: Color.cerdikiawanWhite, choice: Choice(choiceId: choice.choiceId, choiceDescription: choice.choiceDescription))
                                .onTapGesture {
                                    selectedAnswer = choice.choiceId
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(50)
    }
    
}

#Preview {
    QuizMultiChoiceView(tipeQuiz: "implisit")
        .environment(QuizModelData())
}
