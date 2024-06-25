import SwiftUI

struct ConnectBoxView: View {
    var choice: Choice
    var boxColor: Color
    var selectedFrom: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.cerdikiawanGreyMid.opacity(0.5))
                .overlay {
                    ZStack {
                        // TODO: RoundedRectangle with corner radius as a background view in a zstack is often used. Create a function for that purpose. Also have the value of the corner radius to be a variable that is configurable consistently
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(boxColor)
                            .mask {
                                RoundedRectangle(cornerRadius: 10)
                                    .offset(y: -4)
                            }
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.cerdikiawanGreyMid.opacity(0.5), lineWidth: 3)
                    }
                }
            
            HStack {
                if selectedFrom == "Right" {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(boxColor == Color.cerdikiawanWhite ? Color.cerdikiawanBlack : Color.cerdikiawanWhite)
                        .padding(.leading, 22)
                } else {
                    Spacer()
                }
                
                Text(choice.choiceDescription)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(boxColor == Color.cerdikiawanWhite ? Color.cerdikiawanBlack : Color.cerdikiawanWhite)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 22)
                    .fixedSize(horizontal: false, vertical: true)
                
                if selectedFrom == "Left" {
                    Spacer()
                    Image(systemName: "circle.fill")
                        .foregroundStyle(boxColor == Color.cerdikiawanWhite ? Color.cerdikiawanBlack : Color.cerdikiawanWhite)
                        .padding(.trailing, 22)
                } else {
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
        }
        .frame(width: 271, height: 71)
    }
}

#Preview {
    ConnectBoxView(choice: Choice(choiceId: 1, choiceDescription: "Orang yang ahli dalam mencipta dan menggubah gerak tari"), boxColor: Color.cerdikiawanWhite, selectedFrom: "Right")
}
