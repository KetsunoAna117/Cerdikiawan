//
//  CendekiawanApp.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 19/06/24.
//

import SwiftUI
import Firebase

@main
struct CendekiawanApp: App {
//    @StateObject var databaseHelper = DatabaseHelper()
//    @StateObject var userData = User(name: "Test1", level: Level())
    
    init() {
        FirebaseApp.configure() //combine with the info.plist of GoogleService
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
//                .environmentObject(databaseHelper)
        }
    }
}
