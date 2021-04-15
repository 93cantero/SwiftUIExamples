// Created by Cantero on 03/04/2021.

import Foundation
import Combine

extension Int {
    static let defaultAnimationMilliseconds: Int = 300
}

class ItunesSearchViewModel: ObservableObject {
    
    @Published private(set) var models: [SearchItem] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    private var textCancellable: AnyCancellable?
    private var cancellable: AnyCancellable?
    private let repository: SearchResultsRepositoryProtocol
    
    init(repository: SearchResultsRepositoryProtocol = SearchResultsRepository()) {
        self.repository = repository
        subscribeToTextChanges()
    }
    
    func cancelSearch() {
        if searchText.isEmpty {
            models = []
        }
    }
    
    private func searchApps(matching: String) {
        isLoading = true
        cancellable = repository
            .loadResults(matching: matching)
            .receive(on: DispatchQueue.main)
            .map(\.results)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: ", error)
                }
            } receiveValue: { [weak self] result in
                self?.isLoading = false
                self?.models = result
            }
    }
    
    private func subscribeToTextChanges() {
        textCancellable = $searchText
            .debounce(for: .milliseconds(.defaultAnimationMilliseconds), scheduler: RunLoop.main)
            .filter { !$0.isEmpty }
            .sink { text in
                self.searchApps(matching: text)
            }
    }
}
