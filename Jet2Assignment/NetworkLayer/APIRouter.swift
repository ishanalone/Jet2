//
//  APIRouter.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 04/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//


import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
}

extension APIRouter {
    
    var baseURL: String {
        return "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1"
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json","os":"iOS"]
    }
    
    var version: String {
        return ""
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var url: URL {
           switch httpMethod {
           case .get:
               var parameterString : String?
               if (parameters != nil) {
                   parameterString = Helper.makeUrlWithParameters(parameters!)
               }
               return URL.init(string: self.baseURL + self.path + (parameterString ?? ""))!
           default:
               return URL.init(string: self.baseURL + self.path)!
           }
       }

       
       func asURLRequest() throws -> URLRequest {
        print("URL : \(url)")
           var urlRequest = URLRequest.init(url: self.url)
           urlRequest.httpMethod = httpMethod.rawValue
//           urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.headers = headers!
           if httpMethod == .post{
               if let parameters = parameters {
                   let jsonData = Helper.makeHttpBodyWithParameters(parameters)
                   if let bodyData = jsonData {
                       urlRequest.httpBody = bodyData
                   }
               }
           }
           return urlRequest
       }
}
