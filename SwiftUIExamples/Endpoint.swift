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
        
        print("------------------- REQUEST ----------------------------")
        print(request)
        print(request.allHTTPHeaderFields)
        return request
    }
}

// MARK: - Another Option

//protocol TargetAPI {
//    associatedtype ResponseType
//    
//    var baseUrl: String { get }
//    var parameters: JSONObject? { get }
//    var method: HTTPMethod { get }
//    var path: String { get }
//    var headers: [String: String]? { get }
//}

//extension TargetAPI {
//
//    var queryItems: [URLQueryItem] {
//        self.parameters?
//            .compactMap { URLQueryItem(name: $0.key, value: "\($0.value)") } ?? []
//    }
//
//    var method: HTTPMethod { .get }
//
//    var headers: [String : String]? { nil }
//}
//
//extension TargetAPI {
//    var absoluteUrl: String {
//        return "\(baseUrl)\(path)"
//    }
//    var description: String { return self.absoluteUrl }
//
//    func makeRequest() -> URLRequest? {
//        var components = URLComponents()
//        components.scheme = Scheme.https.rawValue
//        components.host = Configuration.environment.host.rawValue
//        components.path = "/" + path
//        components.queryItems = queryItems.isEmpty ? nil : queryItems
//
//        guard let url = components.url else {
//            return nil
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//
//        return request
//    }
//}
//
//enum SearchEndpoint<T> {
//    case search(term: String)
//}
//
//extension SearchEndpoint: TargetAPI {
//    typealias ResponseType = T
//
//    var baseUrl: String {
//        ""
//    }
//
//    var parameters: JSONObject? {
//        switch self {
//        case .search(let term): return ["term": term,
//                                        "entity": "software",
//                                        "limit": 20]
//        }
//    }
//
//    var path: String {
//        "search"
//    }
//}
