//
//  View1.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 25/06/24.
//

import SwiftUI

struct View1: View {
    
    var body: some View {
        NavigationStack {
                    VStack {
                        Text("Home Page")
                            .font(.largeTitle)
                            .padding()
                        
                        NavigationLink(destination: View2()) {
                            Text("Go to Quiz")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                }
    }
}

#Preview {
    View1()
}
