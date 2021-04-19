// Created by Cantero on 15/04/2021.

import XCTest
@testable import SwiftUIExamples

extension Endpoint {
    func expectedURL(env: AppEnvironment = Configuration.environment, path: String) throws -> URL {
        let url = URL(string: "\(env.scheme.rawValue)://" + env.host.rawValue + "/" + path)
        return try XCTUnwrap(url)
    }
}

class EndpointTests: XCTestCase {

    typealias PublicEndpoint = Endpoint<EndpointKinds.Public, String>
    typealias AuthenticatedEndpoint = Endpoint<EndpointKinds.Authenticated, String>

    let host = URLHost(rawValue: "test")

    func test_BasicRequestGeneration() throws {
        // Given
        let path = "path/list"
        let endpoint = PublicEndpoint(path: path)
        
        // When
        let request = endpoint.makeRequest()

        // Then
        try XCTAssertEqual(request?.url, endpoint.expectedURL(path: path))
    }
    
//    func test_GeneratingRequest_WithParameters() throws {
//        // Given
//        let path = "path/list"
//        let endpoint = PublicEndpoint(path: path,
//                                      parameters: ["key1": "value1",
//                                                   "key2": "value2"])
//        // When
//        let request = endpoint.makeRequest()
//
//        //Then
//        try XCTAssertEqual(request?.url, endpoint.expectedURL(path: "path/list?key1=value1&key2=value2"))
//    }
    
    func test_GeneratingPOSTRequest_WithParameters() throws {
        // Given
        let path = "path/list"
        let endpoint = PublicEndpoint(path: path,
                                      method: .post,
                                      parameters: ["key1": "value1",
                                                   "key2": "value2"])
        // When
        let request = endpoint.makeRequest()
        
        //Then
        let exp: [String: String] = [
            "key1": "value1",
            "key2": "value2"
        ]
        let bodyData = try XCTUnwrap(request?.httpBody)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: bodyData) as? [String: String])
        try XCTAssertEqual(request?.url, endpoint.expectedURL(path: "path/list"))
        XCTAssertEqual(json, exp)
    }
    
    func test_AddingAccessTokenToAuthenticatedEndpoint() throws {
        // Given
        let endpoint = AuthenticatedEndpoint(path: "path")
        let token = AccessToken(rawValue: "access_token_12345")
        
        // When
        let request = endpoint.makeRequest(with: token)
        
        // Then
        try XCTAssertEqual(request?.url, endpoint.expectedURL(path: "path"))
        XCTAssertEqual(request?.allHTTPHeaderFields, [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token.rawValue)"
        ])
    }
}
