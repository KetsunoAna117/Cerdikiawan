//
//  DroppableBox.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 20/06/24.
//

import SwiftUI

struct DroppableBox: View {
    var boxText: String
    var body: some View {
        ZStack{
            Text(boxText)
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 150, height: 40)
                .foregroundColor(Color(.secondarySystemFill))
        }
    }
}

#Preview {
    DroppableBox(boxText: "lol")
}
