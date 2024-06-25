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
            .padding()
            .background(color)
            .cornerRadius(5)
            .foregroundStyle(color == Color.white ? Color.black : Color.white)
            .font(.body)
            .fontWeight(.bold)
            .shadow(radius: 5, y: 4)
    }
}

#Preview {
    SubmitButton(text: "Test", color: Color.cerdikiawanGreyMid)
}
