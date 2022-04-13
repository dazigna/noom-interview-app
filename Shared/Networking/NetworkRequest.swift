//
//  NetworkAPI.swift
//  InterviewNoom
//
//  Created by Yacine Alami on 13/04/2022.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

protocol CustomCodable: Codable{
    func encode() throws -> Data
}

extension CustomCodable{
    func encode() throws -> Data{
        guard let jsonData = try? JSONEncoder().encode(self) else {
            throw NetworkError.encodingError(reason: "Failed to encode request Body to JSON")
        }
        return jsonData
    }
}

struct NetworkRequest{
    
    let path: String
    let host: String
    let parameters: CustomCodable?
    let httpMethod: HTTPMethod
    var headers: [String: Any]
    
    init(host: String = "", path: String, parameters: CustomCodable? = nil, httpMethod: HTTPMethod = .GET, headers: [String: Any] = [:]) {
        self.host = host
        self.path = path
        self.parameters = parameters
        self.httpMethod = httpMethod
        self.headers = headers
    }
    
    func toURLRequest() throws -> URLRequest? {
        var urlrequest: URLRequest
        
        let fullPath = host + path
        
        var overrideHeaders = headers
        guard let url = URL(string: fullPath) else {
            return nil
        }
        
        if self.httpMethod == .POST || self.httpMethod == .PUT || self.httpMethod == .PATCH {
            urlrequest = URLRequest(url: url)
            urlrequest.httpMethod = self.httpMethod.rawValue

         
            if let params = self.parameters { // used all the time for any JSON payload
                // add params as JSON body
                guard let jsonData = try? params.encode() else {
                    throw NetworkError.encodingError(reason: "Failed to encode request Body to JSON")
                }
                overrideHeaders["Content-Type"] = "application/json"
                urlrequest.httpBody = jsonData
            }
        } else {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            
            if let paramDict = parameters?.toDictionary() {
                components!.queryItems = paramDict.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
            }
            urlrequest = URLRequest(url: components!.url!)
            urlrequest.httpMethod = self.httpMethod.rawValue
        }
        
        overrideHeaders["Content-Length"] = urlrequest.httpBody?.count.toString()
        urlrequest.allHTTPHeaderFields = overrideHeaders as? [String: String] ?? [:]
        return urlrequest
    }
}

extension NetworkRequest{
    
    static func getFruits(host: String) -> NetworkRequest{
        return NetworkRequest(host: host, path: "/all")
    }
    
    static func getSingleFruit(host: String, parameters: [String: Any]) -> NetworkRequest{
        return NetworkRequest(host: host, path: "/")
    }
}
