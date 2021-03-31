// Created by Cantero on 30/03/2021.

import Foundation
import Combine

struct NetworkingClient {
    var urlSession = URLSession.shared
    
    func request<K, R>(endpoint: Endpoint<K, R>, using requestData: K.RequestData) -> AnyPublisher<R, Error> {
        // We might want to check here if the access token should be refreshed and retry all api calls.
        urlSession.publisher(forEndpoint: endpoint, using: requestData)
    }
}
