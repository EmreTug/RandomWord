//
//  NetworkManager.swift
//  RandomWord
//
//  Created by Emre Tuğ on 8.02.2024.
//
import Foundation
class NetworkManager{
    static let shared = NetworkManager()
    func request<T:Codable>(type:T.Type, urlString:String,method:HTTPMethods,headers:[String:String]? = nil,parameters:[[String:Any]]? = nil,completion:@escaping((Result<T,ErrorTypes>)->()) ){
        
        if let url = URL(string: urlString){
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            if let headers = headers{
                request.allHTTPHeaderFields = headers
            }
            if let parameters = parameters{
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters as Any)
                } catch {
                    print("Error encoding parameters: \(error)")
                    return
                }
            }
           
            let task =  URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = error{
                    completion(.failure(.invalidUrl))
                }
                else if let data = data {
                    self.handleResponse(data) { response in
                        completion(response)
                    }
                }
                else{
                    completion(.failure(.invalidUrl))
                }
            }
            task.resume()
            
        }
        
        
    }
    
    func handleResponse<T:Codable>(_ data : Data,completion:@escaping((Result<T,ErrorTypes>)->()) ){
        let decoder = JSONDecoder()
        do {
           let decodedData =  try decoder.decode(T.self, from: data)
            completion(.success(decodedData))
        } catch  {
            print(error)
            completion(.failure(.invalidData))
        }
    }
}
