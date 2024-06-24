//
//  StatsOverlay.swift
//  Cendekiawan
//
//  Created by Roland Ramadan on 24/06/24.
//

import SwiftUI

struct StatsOverlay: View {
    @StateObject private var user: User = User(name: "Test")
    var body: some View {
        Text("level: \(user.difficultyLevel)")
            .font(.system(size: 25))
        HStack{
            VStack{
                Text(String(user.proficiencyLevelIdePokok))
                    .font(.system(size: 25))
                ZStack(alignment: .bottom){
                    Rectangle()
                        .frame(width: 50, height: 100)
                        .foregroundStyle(.white)
                        .border(Color.black)
                    Rectangle()
                        .frame(width: 50, height: CGFloat(user.proficiencyLevelIdePokok)*10)
                        .foregroundStyle(.green)
                }
                Text("IP")
                    .font(.system(size: 25))
            }
            VStack {
                Text(String(user.proficiencyLevelImplisit))
                    .font(.system(size: 25))
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .frame(width: 50, height: 100)
                        .foregroundStyle(.white)
                        .border(Color.black)
                    Rectangle()
                        .frame(width: 50, height: CGFloat(user.proficiencyLevelImplisit)*10)
                        .foregroundStyle(.red)
                }
                Text("IM")
                    .font(.system(size: 25))
            }
            VStack {
                Text(String(user.proficiencyLevelKosakata))
                    .font(.system(size: 25))
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .frame(width: 50, height: 100)
                        .foregroundStyle(.white)
                        .border(Color.black)
                    Rectangle()
                        .frame(width: 50, height: CGFloat(user.proficiencyLevelKosakata)*10)
                        .foregroundStyle(.blue)
                }
                Text("KOS")
                    .font(.system(size: 25))
            }
        }
    }
}

#Preview {
    StatsOverlay()
}
