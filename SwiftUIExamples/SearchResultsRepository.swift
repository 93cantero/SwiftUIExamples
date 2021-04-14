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
    func loadResults(matching query: String) -> AnyPublisher<SearchResult, Error>
}

struct SearchResultsRepository: SearchResultsRepositoryProtocol {
    
    var urlSession = URLSession.shared
    
    func loadResults(matching query: String) -> AnyPublisher<SearchResult, Error> {
        urlSession.publisher(forEndpoint: .search(matching: query), using: ())
    }
}
