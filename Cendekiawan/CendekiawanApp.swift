//
//  CendekiawanApp.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 19/06/24.
//

import SwiftUI

@main
struct CendekiawanApp: App {
//    @StateObject var databaseHelper = DatabaseHelper()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
//                .environmentObject(databaseHelper)
        }
    }
}
