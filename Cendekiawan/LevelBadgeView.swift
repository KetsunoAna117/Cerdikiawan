//
//  LevelBadgeView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 25/06/24.
//

import SwiftUI

struct LevelBadgeView: View {
    var level: Int
    var body: some View {
        ZStack {
            Image(level < 5 ? "LowLevelBadge" : "HighLevelBadge")
                .resizable()
                .frame(width: 59, height: 59)
            Text("\(level)")
                .foregroundStyle(Color.cerdikiawanWhite)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .frame(width: 59, height: 59)
    }
}

#Preview {
    LevelBadgeView(level: 4)
}
