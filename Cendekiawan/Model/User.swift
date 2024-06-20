//
//  User.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 20/06/24.
//

import SwiftUI

//cara pakenya tinggal declare stateobject si class User trus ubah aja user.exp udh auto update kalo ada Text()
class User: ObservableObject {
    let levelStorage = Level()
    @Published var name: String
    
    @Published var exp: Int {
        didSet {
            let check = levelStorage.updateLevel(exp)
            if check {
                exp = levelStorage.exp  // Reset exp after level up
            }
        }
    }
    
    init(name: String) {
        self.name = name
        self.exp = levelStorage.exp
    }
}
