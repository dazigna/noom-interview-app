//
//  NetworkError.swift
//  InterviewNoom
//
//  Created by Yacine Alami on 13/04/2022.
//

import Foundation

enum NetworkError: Swift.Error, Equatable{
    case badUrl(reason: String? = nil)
    case serverError(reason: String? = nil)
    case clientError(reason: String? = nil)
    case rateLimited(reason: String? = nil)
    case serverBusy(reason: String? = nil)
    case apiNotFound(reason: String? = nil)
    case networkError(reason: String? = nil)
    case unknownError(reason: String? = nil)
    case encodingError(reason: String? = nil)
    
    public var errorDescription: String {
        switch self {
        case .serverError(let response):
            return "Server failure" + message(for: response)
        case .networkError(let response):
            return "Network failed" + message(for: response)
        case .unknownError(let response):
            return "Unknown Error" + message(for: response)
        case .apiNotFound(let response):
            return "API not found on server - 404" + message(for: response)
        case .rateLimited(let response):
            return "Request has been rate limited" + message(for: response)
        case .serverBusy(let response):
            return "server is busy" + message(for: response)
        case .clientError(let response):
            return "Client request malformed" + message(for: response)
        case .badUrl(reason: let response):
            return "URL badly formatted" + message(for: response)
        case .encodingError(reason: let response):
            return "Could not encode data" + message(for: response)
        }
    }
    
    private func message(for response: String?) -> String {
        if let response = response {
            return ": \(response)"
        } else {
            return ""
        }
    }
    
    public static func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case
            (.serverError, .serverError),
            (.apiNotFound, .apiNotFound),
            (.networkError, .networkError),
            (.unknownError, .unknownError),
            (.rateLimited, .rateLimited),
            (.clientError, .clientError),
            (.serverBusy, .serverBusy),
            (.encodingError, .encodingError):
            return true
        default:
            return false
        }
    }
}
