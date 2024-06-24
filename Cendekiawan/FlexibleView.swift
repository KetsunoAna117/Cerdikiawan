//
//  FlexibleView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 24/06/24.
//

import SwiftUI

struct FlexibleView: View {
    let availableWidth: CGFloat
    let views: [AnyView]
    
    var body: some View {
        var width: CGFloat = 0
        var rows: [[AnyView]] = [[]]
        
        for view in views {
            let viewWidth = view.width
            
            if width + viewWidth > availableWidth {
                rows.append([view])
                width = viewWidth
            } else {
                rows[rows.count - 1].append(view)
                width += viewWidth
            }
        }
        
        return VStack(alignment: .leading, content: {
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack {
                    ForEach(rows[rowIndex].indices, id: \.self) { viewIndex in
                        rows[rowIndex][viewIndex]
                    }
                }
            }
        })
    }
}

#Preview {
    FlexibleView(availableWidth: 200, views: [])
}
