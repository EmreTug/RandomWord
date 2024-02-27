//
//  WordManager.swift
//  RandomWord
//
//  Created by Emre Tuğ on 3.02.2024.
//

import Foundation


class WordManager{
    static let shared = WordManager()
 
    func fetchWordofDay(completion: @escaping ((WordOfDayModel?,String?)->())){
        
        let urlString = "https://api.wordnik.com/v4/words.json/wordOfTheDay?api_key=vs7yddlrkvgk3nbmaporwgmfqvoxn7yrwzfvisjjlv965zqnl"
        NetworkManager.shared.request(type: WordOfDayModel.self, urlString: urlString, method: .get) { response in
            switch response {
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                completion(nil,error.rawValue)
            }
            
        }
    }
   

    func fetchDefinitions(word:String,completion: @escaping (([DictionaryModel]?,String?)->())){

        let urlString = "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)"
        NetworkManager.shared.request(type: [DictionaryModel].self, urlString: urlString, method: .get) { response in
            switch response {
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                completion(nil,error.rawValue)
            }
            
        }
    }
    
    

    func fetchWord(size: Int, completion: @escaping (([String:String])->())) {
        var words : [String : String] = [:]
        for _ in 0..<size {
            let element =  DataClass.instance.wordsDataList.randomElement()
            if let element = element{
                words[element.key] = element.value
            }
           
        }
            completion(words)
           
       }
      
      
 
}
