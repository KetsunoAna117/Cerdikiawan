//
//  QuizMultiChoiceView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct QuizMultiChoiceView: View {
    @State var selectedAnswer = -1 // 0 - 3
    
    @State var choices = [Choice(choiceId: 1, choiceDescription: "jawaban A"), Choice(choiceId: 2, choiceDescription: "jawaban B"), Choice(choiceId: 3, choiceDescription: "jawaban C"), Choice(choiceId: 4, choiceDescription: "jawaban D")]
    
    var body: some View {
        HStack{
            VStack{
                Text("KOCHENG")
                    .padding([.bottom], 20)
                Image("placeholderPhoto")
                    .padding([.bottom], 50)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            }
            .frame(maxWidth: .infinity)
            Spacer(minLength: 20)
            VStack(alignment: .leading, spacing: 20){
                Text("Some questions blablablablablablablabbla?")
                
                
                ForEach(choices) { choice in
                    AnswerButton(isClicked: choice.choiceId == selectedAnswer, choice: choice)
                        .onTapGesture {
                            selectedAnswer = choice.choiceId
                        }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(50)
    }
}

#Preview {
    QuizMultiChoiceView()
}

class Choice: Identifiable, Codable, Hashable {
    var choiceId: Int
    var choiceDescription: String
    
    init(choiceId: Int, choiceDescription: String) {
        self.choiceId = choiceId
        self.choiceDescription = choiceDescription
    }
    
    static func == (lhs: Choice, rhs: Choice) -> Bool {
        return lhs.choiceId == rhs.choiceId && lhs.choiceDescription == rhs.choiceDescription
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(choiceId)
        hasher.combine(choiceDescription)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        choiceId = try container.decode(Int.self, forKey: .choiceId)
        choiceDescription = try container.decode(String.self, forKey: .choiceDescription)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(choiceId, forKey: .choiceId)
        try container.encode(choiceDescription, forKey: .choiceDescription)
    }
    
    private enum CodingKeys: String, CodingKey {
        case choiceId, choiceDescription
    }
}

class DraggableChoice: Choice, Transferable {
    var uniqueId: UUID
    
    init(choiceId: Int, choiceDescription: String, uniqueId: UUID = UUID()) {
        self.uniqueId = uniqueId
        super.init(choiceId: choiceId, choiceDescription: choiceDescription)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uniqueId = try container.decode(UUID.self, forKey: .uniqueId)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uniqueId, forKey: .uniqueId)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case uniqueId
    }

    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .draggableChoice)
    }
}

extension UTType {
    static let draggableChoice = UTType(exportedAs: "appleacad.mini2.Cendekiawan.draggableChoice")
}
