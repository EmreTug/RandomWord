//
//  Dictionary.swift
//  RandomWord
//
//  Created by Emre Tuğ on 26.02.2024.
//

import Foundation

// MARK: - DictionaryModelElement
struct DictionaryModel: Codable {
    let word, phonetic: String?
    let phonetics: [Phonetic]?
    let meanings: [Meaning]?
}


// MARK: - Meaning
struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [WordDefinition]
    let synonyms, antonyms: [String]?
}

// MARK: - Definition
struct WordDefinition: Codable {
    let definition: String
    let synonyms, antonyms: [String]?
    let example: String?
}

// MARK: - Phonetic
struct Phonetic: Codable {
    let text: String?
    let audio: String?
}
