//
//  Button3D.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 24/06/24.
//

import SwiftUI

struct Button3D: View {
    
    var text: String
    var color: Color
    var body: some View {
        Text(text)
            .padding()
            .background(Color.cerdikiawanGreyMid)
            .cornerRadius(5)
            .foregroundStyle(color == Color.cerdikiawanWhite ? Color.cerdikiawanBlack : Color.cerdikiawanWhite)
            .font(.body)
            .fontWeight(.bold)
            .overlay{
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(color)
                        .mask {
                            RoundedRectangle(cornerRadius: 5)
                                .offset(y: -4)
                        }
                    Text(text)
                        .foregroundStyle(color == Color.cerdikiawanWhite ? Color.cerdikiawanBlack : Color.cerdikiawanWhite)
                        .font(.body)
                        .fontWeight(.bold)
                    if color == Color.white {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.cerdikiawanGreyMid, lineWidth: 1)
                    }
                }
            }
    }
}

#Preview {
    Button3D(text: "coba-coba", color: Color.cerdikiawanWhite)
}
