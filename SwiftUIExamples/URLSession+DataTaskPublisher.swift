// Created by Cantero on 29/03/2021.

import Foundation
import Combine

extension URLSession {
    func publisher<K, R>(forEndpoint endpoint: Endpoint<K, R>,
                         using requestData: K.RequestData,
                         decoder: JSONDecoder = .init()) -> AnyPublisher<R, Error> {
        guard let request = endpoint.makeRequest(with: requestData) else {
                    return Fail(error: InvalidEndpointError(endpoint: endpoint))
                        .eraseToAnyPublisher()
                }
        
        return dataTaskPublisher(for: request)
            .validateStatusCode(in: 200...299)
            .map(\.data)
            .decode(using: decoder)
            .eraseToAnyPublisher()
    }
}
