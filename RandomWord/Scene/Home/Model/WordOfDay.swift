//
//  WordOfDayData.swift
//  RandomWord
//
//  Created by Emre Tuğ on 11.02.2024.
//

import Foundation

struct WordOfDayModel: Codable {
    var word: String
    let note: String
    let definitions: [Definition]
    let examples: [Example]
  
}
// MARK: - Definition
struct Definition: Codable {
    let text, partOfSpeech, source: String
}

// MARK: - Example
struct Example: Codable {
    let url: String
    let text, title: String
    let id: Int
}

