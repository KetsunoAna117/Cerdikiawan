//
//  LineConnectionView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 23/06/24.
//

import SwiftUI

struct LineConnectionView: View {
    var connections: [(left: CGPoint, right: CGPoint)]
    var body: some View {
        Path { path in
            for connection in connections {
                path.move(to: connection.left)
                path.addLine(to: connection.right)
            }
        }
        .stroke(.blue, lineWidth: 10)
    }
}

#Preview {
    LineConnectionView(connections: [(CGPoint(x: 0, y: 0), CGPoint(x: 100, y: 100)), (CGPoint(x: 100, y: 200), CGPoint(x: 200, y: 300))])
}
