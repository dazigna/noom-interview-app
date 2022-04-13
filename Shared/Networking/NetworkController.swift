//
//  NetworkController.swift
//  InterviewNoom
//
//  Created by Yacine Alami on 13/04/2022.
//

import Foundation

protocol NetworkControllerInterface{
    func baseRequest(_ urlSession: URLSession, request: NetworkRequest) async -> Result<Data, Error>
    func request<T: Codable>(_ urlSession: URLSession, request: NetworkRequest) async -> Result<T, Error>
}

struct NetworkController: NetworkControllerInterface {
    func baseRequest(_ urlSession: URLSession, request: NetworkRequest) async ->  Result<Data, Error> {
        guard let urlRequest = try? request.toURLRequest() else {
            return .failure(NetworkError.encodingError(reason: "Could not encode URL request"))
        }
        do{
           let (data, response) = try await urlSession.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkError.serverError(reason: "Failed to cast"))
            }
            
            let responseString = String(data: data, encoding: .utf8) ?? ""
            switch httpResponse.statusCode{
            case 200..<300:
                break
            case 400..<500:
                return .failure(NetworkError.clientError(reason: responseString))
            case 500..<600:
                return .failure(NetworkError.serverError(reason: responseString))
            default:
                return .failure(NetworkError.serverError(reason: responseString))
            }
            return .success(data)
        } catch let error{
            return .failure(NetworkError.networkError(reason: error.localizedDescription))
        }
    }
    
    func request<T>(_ urlSession: URLSession, request: NetworkRequest) async -> Result<T, Error> where T : Decodable, T : Encodable {
        let result = await baseRequest(urlSession, request: request)
        switch result{
        case let .success(data):
            do {
                let body = try JSONDecoder().decode(T.self, from: data)
                return .success(body)
            } catch let error{
                return .failure(NetworkError.encodingError(reason: error.localizedDescription))
            }
        case let .failure(error):
            return .failure(error)
        }
    }
}
