//
//  NetworkHelper.swift
//  RandomWord
//
//  Created by Emre Tuğ on 8.02.2024.
//

import Foundation

class NetworkHelper{
    
    static let shared = NetworkHelper()
    
    
    
    
    
    func saveToken(){
        //save to keychain
    }
    
}


enum HTTPMethods:String{
    case get = "GET"
    case post = "POST"
}
enum ErrorTypes:String,Error{
    case invalidData = "data is invalid"
    case invalidUrl = "url is invalid"
    case generalError = "general error"
}

