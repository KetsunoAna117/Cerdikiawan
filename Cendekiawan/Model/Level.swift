//
//  Level.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 20/06/24.
//

import SwiftUI

class Level {
    @AppStorage("levelValue") var value: Int = 0
    @AppStorage("levelExp") var exp: Int = 0
}
