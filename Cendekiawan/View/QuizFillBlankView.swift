//
//  QuizFillBlankView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct QuizFillBlankView: View {
    @State var questions = "Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem -?- sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem -?- Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem -?- Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem ipsum dolor sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet lorem -?- sit amet Lorem Ipsum dolor sit amet lorem ipsum Lorem Ipsum dolor sit amet "
    var body: some View {
        Text("Fill In The Blank")
    }
}

#Preview {
    QuizFillBlankView()
}
