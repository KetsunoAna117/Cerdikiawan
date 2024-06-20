//
//  Choice.swift
//  Cendekiawan
//
//  Created by Bryan Vernanda on 19/06/24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

class Choice: Identifiable, Codable, Hashable {
    var choiceID: Int
    var choiceText: String
    
    init(choiceID: Int, choiceText: String) {
        self.choiceText = choiceText
        self.choiceID = choiceID
    }
    
    static func == (lhs: Choice, rhs: Choice) -> Bool {
        return lhs.choiceID == rhs.choiceID && lhs.choiceText == rhs.choiceText
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(choiceID)
        hasher.combine(choiceText)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        choiceID = try container.decode(Int.self, forKey: .choiceID)
        choiceText = try container.decode(String.self, forKey: .choiceText)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(choiceID, forKey: .choiceID)
        try container.encode(choiceText, forKey: .choiceText)
    }
    
    private enum CodingKeys: String, CodingKey {
        case choiceID, choiceText
    }
}


class DraggableChoice: Choice, Transferable {
    var uniqueId: UUID
    
    init(choiceID: Int, choiceText: String, uniqueId: UUID = UUID()) {
        self.uniqueId = uniqueId
        super.init(choiceID: choiceID, choiceText: choiceText)
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
