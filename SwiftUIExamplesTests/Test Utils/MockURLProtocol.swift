// Created by Cantero on 15/04/2021.
import XCTest
@testable import SwiftUIExamples
import Combine

enum MockError: Error {
    case fail
}

class MockClient: APIClient {
    private var urlSession: URLSession
        
    init<T: MockURLRequester>(mockRequester: T.Type) {
        urlSession = .init(mockRequester: mockRequester)
    }
    
    func request<K, R>(endpoint: Endpoint<K, R>,
                       using requestData: K.RequestData) -> AnyPublisher<R, Error> {
        return Empty().eraseToAnyPublisher()
    }
}

extension NetworkingClient {
    init<T: MockURLRequester>(mockRequester: T.Type) {
        self = Self.init(urlSession: .init(mockRequester: mockRequester))
    }
}

extension URLSession {
    convenience init<T: MockURLRequester>(mockRequester: T.Type) {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol<T>.self]
        self.init(configuration: config)
        URLProtocol.registerClass(MockURLProtocol<T>.self)
    }
}

// MARK:- MockURLRequester

protocol MockURLRequester {
    static func respond(to request: URLRequest) throws -> Data
}

class MockURLProtocol<Requester: MockURLRequester>: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let client = client else { return }

        do {
            let data = try Requester.respond(to: request)
            let response = try XCTUnwrap(HTTPURLResponse(
                url: XCTUnwrap(request.url),
                statusCode: 200,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            ))

            client.urlProtocol(self,
                didReceive: response,
                cacheStoragePolicy: .notAllowed
            )
            client.urlProtocol(self, didLoad: data)
        } catch {
            client.urlProtocol(self, didFailWithError: error)
        }

        client.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
    }
}
