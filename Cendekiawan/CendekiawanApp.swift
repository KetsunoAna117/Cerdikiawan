//
//  CendekiawanApp.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 19/06/24.
//

import SwiftUI

@main
struct CendekiawanApp: App {
    @State private var modelData = QuizModelData()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environment(modelData)
            }
        }
    }
}
