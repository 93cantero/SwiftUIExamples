// Created by Cantero on 29/03/2021.

import Foundation
import Combine

private extension Endpoint where Kind == EndpointKinds.Public, Response == SearchResult {

    static func search(matching query: String) -> Self {
        Endpoint(path: "search",
                 parameters: ["term" : query,
                              "limit": "20",
                              "entity": "software"])
    }
}

protocol SearchResultsRepositoryProtocol {
    func loadResults(matching query: String) -> AnyPublisher<[SearchItem], Error>
}

struct SearchResultsRepository: SearchResultsRepositoryProtocol {
    var client: APIClient = NetworkingClient()
    
    func loadResults(matching query: String) -> AnyPublisher<[SearchItem], Error> {
        client
            .request(endpoint: .search(matching: query))
            .map(\.results)
            .eraseToAnyPublisher()
    }
}
