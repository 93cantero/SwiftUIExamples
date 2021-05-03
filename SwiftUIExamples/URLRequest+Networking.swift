// Created by Cantero on 29/03/2021.

import Foundation

extension URLRequest {
    
    mutating func add(parameters: JSON, with httpMethod: HTTPMethod) {
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        switch httpMethod {
        case .get: add(urlParameters: parameters)
        case .post: add(bodyParameters: parameters)
        }
    }
    
    mutating func add(bodyParameters params: JSON) {
        do {
            httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch let error {
            assertionFailure(error.localizedDescription)
        }
    }
    
    mutating func add(urlParameters parameters: JSON) {
        let queryItems = parameters.toQueryItems()
        var components = URLComponents(url: url!, resolvingAgainstBaseURL: false)!
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        url = components.url
    }
    
    mutating func add(headers: [String: String]?) {
        headers?.forEach { self.setValue($1, forHTTPHeaderField: $0) }
    }
}

private extension JSON {
    
    func toQueryItems() -> [URLQueryItem] {
        compactMap { param -> URLQueryItem? in
            guard let stringValue = param.value as? String else {
                assertionFailure("URL Encoding parameters only support String")
                return nil
            }
            let value = stringValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            return URLQueryItem(name: param.key, value: value)
        }
    }
}
