//
//  View3.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 25/06/24.
//

import SwiftUI

struct View3: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
                    Text("Result Page")
                        .font(.largeTitle)
                        .padding()
                    
            Button {
                dismiss()
            } label: {
                Text("Go back to Home")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
                }
    }
}

#Preview {
    View3()
}
