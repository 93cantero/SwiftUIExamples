// Created by Cantero on 30/03/2021.

import Foundation

typealias RequestParameters = [String: String]
typealias JSONObject = [String: Any]

enum TimeOutInterval: TimeInterval {
    case regular = 30
}

enum APIVersioning: String {
    case `default` = ""
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Scheme: String {
    case https
    case http
}

struct HTTPHeader {
    struct Key {
        static let contentType = "Content-Type"
    }
    
    struct Values {
        static let applicationJSONType = "application/json"
    }
}
