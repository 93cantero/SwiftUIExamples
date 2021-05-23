// Created by Cantero on 29/03/2021.

import Foundation

// MARK: - Endpoint

struct Endpoint<Kind: EndpointType, Response: Decodable> {
    var apiVersion: APIVersioning = .default
    var path: String
    var method: HTTPMethod = .get
    var parameters = JSON()
    var headers: RequestParameters = [:]
}

extension Endpoint where Kind.RequestData == Void {
    func makeRequest() -> URLRequest? {
        makeRequest(with: ())
    }
}

extension Endpoint {
    func makeRequest(with data: Kind.RequestData) -> URLRequest? {
        guard let url = components.url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.add(headers: headers)
        request.add(parameters: parameters, with: method)
        Kind.prepare(&request, with: data)
        
        print("------------------- REQUEST ----------------------------")
        print(request)
        print(request.allHTTPHeaderFields as Any)
        return request
    }
    
    private var components: URLComponents {
        let currentEnv = Configuration.environment
        var components = URLComponents()
        components.scheme = currentEnv.scheme.rawValue
        components.host = currentEnv.host.rawValue
        let apiVersionOrSlash = apiVersion.rawValue.isEmpty ? "" : ("/" + apiVersion.rawValue )
        components.path = apiVersionOrSlash + "/" + path
        return components
    }
}
