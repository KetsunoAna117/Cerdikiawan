//
//  ConnectBoxView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 23/06/24.
//

import SwiftUI

struct ConnectBoxView: View {
    var choice: Choice
    var boxColor: Color
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 155, height: 75)
                .foregroundStyle(boxColor)
            Text(choice.choiceDescription)
                .padding(.vertical, 4)
                .lineLimit(2)
        }
        .frame(maxWidth: 155, maxHeight: 75)
    }
}

#Preview {
    ConnectBoxView(choice: Choice(choiceId: 1, choiceDescription: "Test"), boxColor: Color.blue)
}
