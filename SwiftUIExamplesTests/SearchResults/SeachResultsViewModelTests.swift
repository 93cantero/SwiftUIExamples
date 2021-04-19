// Created by Cantero on 20/04/2021.

import XCTest
@testable import SwiftUIExamples

class SeachResultsViewModelTests: XCTestCase {

    var sut: SearchResultsRepository!

    func test_ViewModelPublisher() throws {
        let client = NetworkingClient(mockRequester: SearchItem.MockSearchItemURLRequester.self)
        let repo = SearchResultsRepository(client: client)
        let sut = ItunesSearchViewModel(repository: repo)
        
        let modelPublisher = sut.$models
            .dropFirst()

        sut.searchText = "Hola"
        
        delay(0.4) {
            sut.searchText = "Hola"
        }
        delay(0.8) {
            sut.searchText = "Hola"
        }

        let models = try awaitCompletion(of: modelPublisher, expectedPublishedValues: 3)
            .flatMap { $0 }
                
        // Then
        let firstItem = SearchItem.createItem(named: "Hola")
        let secondItem = SearchItem.createItem(named: "Apps")
        let thirdItem = SearchItem.createItem(named: "Another")
        // When
//        SearchItem.MockSearchItemURLRequester.response = firstItem
//        sut.searchText = "Hola"
        //        SearchItem.MockSearchItemURLRequester.response = secondItem
//        sut.searchText = "Apps"
        //        SearchItem.MockSearchItemURLRequester.response = thirdItem
//        sut.searchText = "Another"
                
        XCTAssertEqual(models.count, 3)
    }
    
    private func delay(_ seconds: TimeInterval, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: closure)
    }

}
