//
//  BottomConfirmOverlayView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 24/06/24.
//

import SwiftUI

struct BottomConfirmOverlayView: View {
    var isCorrect: Bool
    var description: String
    var button: Button3D
    var action: () -> Void
    var feedback: String
    var body: some View {
        ZStack{
            Rectangle()
                .frame(height: 105)
                .foregroundStyle(Color.cerdikiawanYellowMuda)
            HStack{
                if button.text != "Periksa" {
                        HStack{
                            if isCorrect {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                                    .foregroundStyle(Color.cerdikiawanGreenTua)
                                Text(feedback)
                            } else {
                                VStack(alignment: .leading){
                                    Text("Sedikit lagi sudah benar!")
                                        .foregroundStyle(Color.cerdikiawanBlack)
                                        .font(.headline)
                                    HStack {
                                        Image(systemName: "x.circle.fill")
                                            .resizable()
                                            .frame(width: 23, height: 23)
                                            .foregroundStyle(Color.cerdikiawanRed)
                                        Text(feedback)
                                    }
                            }
                        }
                        
                    }
                        .padding(.leading, 28)
                }
                
                Spacer()
                button
                    .padding([.horizontal], 28)
                    .onTapGesture {
                        action()
                    }
                }
            }
            
            
        }
    }


#Preview {
    BottomConfirmOverlayView(isCorrect: false, description: "", button: Button3D(text: "Lanjut", color: Color.cerdikiawanOrange), action: {}, feedback: "feedback")
}
