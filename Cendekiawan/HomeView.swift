//
//  HomeView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 20/06/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                //          EXP bar
                HStack {
                    HStack(spacing: -6) {
                        ZStack {
                            Circle()
                                .frame(width: 35, height: 35)
                                .foregroundStyle(Color(red: 0.85, green: 0.85, blue: 0.85))
                            Text("15")
                        }
                        .zIndex(10)
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: 128, height: 23)
                                .foregroundStyle(Color(red: 0.48, green: 0.48, blue: 0.48))
                                .cornerRadius(5)
                            Text("exp")
                                .font(
                                    Font.custom("Outfit", size: 17)
                                        .weight(.light)
                                )
                                .foregroundStyle(Color.white)
                                .padding(.leading, 15)
                        }
                        .zIndex(1)
                    }
                    Spacer()
                    
                    HStack {
                        Rectangle()
                            .frame(width: 23, height: 23)
                            .foregroundStyle(Color.gray)
                        Rectangle()
                            .frame(width: 23, height: 23)
                            .foregroundStyle(Color.gray)
                    }
                }
                
                Text("Halo, Username!")
                    .font(
                        Font.custom("Outfit", size: 21)
                            .weight(.bold)
                    )
                    .padding(.bottom, 80)
                
                VStack {
                    HStack (alignment: .top) {
                        Image("avatar-default")
                            .resizable()
                        .frame(width: geometry.size.width / 4, height: geometry.size.width / 3)
                        Button {
                            // do something
                        } label: {
                            Text("Change Avatar")
                                .padding(.horizontal, 10)
                        }
                        .buttonStyle(BorderedButtonStyle())

                    }
                    .padding(.bottom, 50)
                    .frame(maxWidth: .infinity, alignment: .top)
                    
                    Button {
                        // do something
                    } label: {
                        Text("Mulai")
                            .padding(.vertical, 5)
                            .padding(.horizontal, geometry.size.width / 5)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                }
                
                
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
