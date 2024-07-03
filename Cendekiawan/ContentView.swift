//
//  ContentView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(QuizModelData.self) private var modelData
    
    var body: some View {
        HomeView()
            .environment(modelData)
    }
}

#Preview {
    ContentView()
        .environment(QuizModelData())
}
