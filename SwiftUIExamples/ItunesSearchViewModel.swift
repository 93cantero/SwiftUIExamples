// Created by Cantero on 03/04/2021.

import Foundation
import Combine

class ItunesSearchViewModel: ObservableObject {
    
    @Published private(set) var models: [SearchItem] = []
    private var cancellable: AnyCancellable?
    let repository: SearchResultsRepositoryProtocol
    
    init(repository: SearchResultsRepositoryProtocol = SearchResultsRepository()) {
        self.repository = repository
    }
    
    func request() {
        cancellable = repository
            .loadResults(matching: "yelp")
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: ", error)
                }
            } receiveValue: { [weak self] result in
                self?.models = result.results
            }
    }
}
