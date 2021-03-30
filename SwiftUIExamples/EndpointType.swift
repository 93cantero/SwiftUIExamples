// Created by Cantero on 30/03/2021.

import Foundation

protocol EndpointType {
    associatedtype RequestData
    
    static func prepare(_ request: inout URLRequest,
                        with data: RequestData)
}

struct AccessToken: RawRepresentable {
    var rawValue: String
}

enum EndpointKinds {
    enum Public: EndpointType {
        static func prepare(_ request: inout URLRequest,
                            with _: Void) {
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.timeoutInterval = TimeOutInterval.regular.rawValue
        }
    }

    enum Authenticated: EndpointType {
        static func prepare(_ request: inout URLRequest,
                            with token: AccessToken) {
            // Will require Authorization or other authentication-related
            request.addValue("Bearer \(token.rawValue)", forHTTPHeaderField: "Authorization")
            request.timeoutInterval = TimeOutInterval.regular.rawValue
        }
    }
    
    enum Other: EndpointType {
        static func prepare(_ request: inout URLRequest,
                            with _: Void) {
        }
    }
}
