//
//  Codable+Extensions.swift
//  InterviewNoom
//
//  Created by Yacine Alami on 13/04/2022.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {return nil}
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }

    func toString() -> String? {
        guard let data = try? JSONEncoder().encode(self) else {return nil}
        return String(data: data, encoding: .utf8)
    }
}
