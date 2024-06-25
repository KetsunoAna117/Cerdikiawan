//
//  SubmitButton.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 24/06/24.
//

import SwiftUI

struct SubmitButton: View {
    var text: String
    var color: Color
    var body: some View {
        Text(text)
            .padding([.horizontal], 99)
            .padding([.vertical], 15)
            .background(color)
            .cornerRadius(30)
            .foregroundStyle(color == Color.cerdikiawanWhite ? Color.cerdikiawanWhite : Color.cerdikiawanWhite)
            .font(.title)
            .fontWeight(.bold)
            .shadow(radius: 5, y: 4)
    }
}

#Preview {
    SubmitButton(text: "Test", color: Color.cerdikiawanOrange)
}
