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
    var choiceDescription: String
    var choiceId: Int
    
    init(choiceId: Int, choiceDescription: String) {
        self.choiceDescription = choiceDescription
        self.choiceId = choiceId
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
        choiceId = try container.decode(Int.self, forKey: .choiceID)
        choiceDescription = try container.decode(String.self, forKey: .choiceText)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(choiceId, forKey: .choiceID)
        try container.encode(choiceDescription, forKey: .choiceText)
    }
    
    private enum CodingKeys: String, CodingKey {
        case choiceID, choiceText
    }
}


class DraggableChoice: Choice, Transferable {
    var uniqueId: UUID
    
    init(choiceID: Int, choiceText: String, uniqueId: UUID = UUID()) {
        self.uniqueId = uniqueId
        super.init(choiceId: choiceID, choiceDescription: choiceText)
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
