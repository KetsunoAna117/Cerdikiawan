//
//  ExpProgressView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 25/06/24.
//

import SwiftUI

struct ExpProgressView: View {
    let progress: CGFloat

      var body: some View {
          ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 30)
              .frame(width: 266, height: 39)
              .opacity(0.3)
              .foregroundColor(Color.black).opacity(0.65)

              ZStack(alignment: .leading){
                  RoundedRectangle(cornerRadius: 30)
                    .frame(width: 262, height: 35)
                    .opacity(0.3)
                    .opacity(0)
                  RoundedRectangle(cornerRadius: 30)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.cerdikiawanOrange,
                                Color.cerdikiawanYellow
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                  .frame(
                    width: min(progress * 262,
                               262),
                    height: 35
                  )
              }
          }
      }
}

#Preview {
    ExpProgressView(progress: 0.5)
}
