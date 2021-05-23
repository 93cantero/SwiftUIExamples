// Created by Cantero on 20/04/2021.

import XCTest
@testable import SwiftUIExamples
import Combine

private class SearchResultRepositoryMock: SearchResultsRepositoryProtocol {
    
    var result: Result<[SearchItem], Error> = .failure(MockError.fail)
    var loadResultsQuery: String?
    
    func loadResults(matching query: String) -> AnyPublisher<[SearchItem], Error> {
        loadResultsQuery = query
        switch result {
        case .success(let value): return .just(value)
        case .failure(let err): return .fail(err)
        }
    }
}

class SeachResultsViewModelTests: XCTestCase {

    var sut: SearchResultsRepository!

    func test_ViewModelPublisher() throws {
        let mockRepo = SearchResultRepositoryMock()
        let sut = ItunesSearchViewModel(repository: mockRepo)
        
        let modelPublisher = sut.$models
            .dropFirst()
        
        let firstItem = SearchItem.createItem(named: "Hola")
        let secondItem = SearchItem.createItem(named: "Apps")
        let thirdItem = SearchItem.createItem(named: "Another")
        
        let actions = {
            // When
            mockRepo.result = .success([firstItem])
            sut.searchText = "First"
            delay(0.4) {
                mockRepo.result = .success([secondItem])
                sut.searchText = "Second"
            }
            delay(0.8) {
                mockRepo.result = .success([thirdItem])
                sut.searchText = "Third"
            }
        }

        let totalModels = try awaitCompletion(of: modelPublisher, expectedPublishedValues: 3, actions: actions)
            .flatMap { $0 }

        XCTAssertEqual(totalModels.count, 3)
        try assertEqual(lhs: totalModels[0], rhs: firstItem)
        try assertEqual(lhs: totalModels[1], rhs: secondItem)
        try assertEqual(lhs: totalModels[2], rhs: thirdItem)
    }
    
    func test_EmptySearchText_DoesNotCallRepository() {
        // Given
        let mockRepo = SearchResultRepositoryMock()
        let sut = ItunesSearchViewModel(repository: mockRepo)
        
        let firstItem = SearchItem.createItem(named: "Hola")
        mockRepo.result = .success([firstItem])
    
        // When
        sut.searchText = ""
        
        let exp = expectation(description: "Wait for delay")
        delay(0.4) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)

        XCTAssertNil(mockRepo.loadResultsQuery)
    }
}
