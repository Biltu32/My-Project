//
//  API_Manager.swift
//  Weather
//
//  Created by DAPL-Asset-210 on 12/07/24.
//

import Foundation
import Alamofire

class API_Manager {
    static let sharedInstance = API_Manager()
    
    func weatherDetails(baseURL:String,completion:@escaping (_ result:Weather?, _ status:Bool, _ message:String) -> Void) {
        let headersAPI: HTTPHeaders = [  .accept("application/json")  ]
        
    AF.request(baseURL,method:.get,parameters:[:],encoding:
    URLEncoding.default,headers:headersAPI,interceptor:nil,requestModifier:nil).response {responseData in
           guard let data = responseData.data else {
           completion(nil,false, responseData.error!.localizedDescription)
           return }
           
           do {
               let getResponse = try JSONDecoder().decode(Weather.self, from: data)
               completion(getResponse, true, "Response Received Successfully")
               }
           catch {
               print("Error After decoding ==> \(error)")
               completion(nil,false, error.localizedDescription)
               }
           
               }
               }
   
    
}
