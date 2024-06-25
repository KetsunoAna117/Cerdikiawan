//
//  ViewA.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 25/06/24.
//

import SwiftUI

struct TestViewMultiChoice: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all) // Extend the background color to the edges of the screen
            Text("MultiChoice")
                .foregroundColor(.white) // Set the text color to white for better contrast
        }
    }
}

#Preview {
    TestViewMultiChoice()
}
