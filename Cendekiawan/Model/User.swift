//
//  User.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 20/06/24.
//

import SwiftUI

//cara pakenya tinggal declare stateobject si class User trus ubah aja user.value ama user.exp udh auto update kalo ada Text()
class User: ObservableObject {
    private let levelStorage = Level()
    @Published var name: String
    
    @Published var value: Int {
        didSet {
            levelStorage.value = value
        }
    }
    
    @Published var exp: Int {
        didSet {
            levelStorage.exp = exp
        }
    }
    
    init(name: String) {
        self.value = levelStorage.value
        self.exp = levelStorage.exp
        self.name = name
    }
}
