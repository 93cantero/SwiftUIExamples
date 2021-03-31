// Created by Cantero on 29/03/2021.

import Foundation

// MARK: - Endpoint

struct Endpoint<Kind: EndpointType, Response: Decodable> {
    var apiVersion: APIVersioning = .default
    var path: String
    var parameters = JSONObject()
    var method: HTTPMethod = .get
    var headers: RequestParameters = [:]
}

extension Endpoint {
    func makeRequest(with data: Kind.RequestData) -> URLRequest? {
        var components = URLComponents()
        components.scheme = Scheme.https.rawValue
        components.host = Configuration.environment.host.rawValue
        let apiVersionOrSlash = apiVersion.rawValue.isEmpty ? "" : ("/" + apiVersion.rawValue )
        components.path = apiVersionOrSlash + "/" + path

        guard let url = components.url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.add(headers: headers)
        request.add(parameters: parameters, with: method)
        Kind.prepare(&request, with: data)
        return request
    }
}
