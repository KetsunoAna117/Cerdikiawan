//
//  View2.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 25/06/24.
//

import SwiftUI

struct View2: View {
    var body: some View {
        VStack {
                    Text("Quiz Page")
                        .font(.largeTitle)
                        .padding()
                    
                    NavigationLink(destination: View3()) {
                        Text("Finish Quiz")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                }
    }
}

#Preview {
    View2()
}
