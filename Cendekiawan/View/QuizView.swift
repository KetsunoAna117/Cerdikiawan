//
//  QuizView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct QuizView: View {
    var body: some View {
        NavigationStack{
            Text("Quiz")
            QuizMultiChoiceView()
        }
    }
}

#Preview {
    QuizView()
}
