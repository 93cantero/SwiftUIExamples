// Created by Cantero on 15/04/2021.
import XCTest
@testable import SwiftUIExamples
import Combine

class SearchResultsRepositoryTests: XCTestCase {
    
    var sut: SearchResultsRepository!
    
    // MARK: Test doubles

    enum MockSearchItemURLRequester: MockURLRequester {
        static let item = SearchItem(artworkUrl100: URL(string: "https://www.google.es")!,
                                     averageUserRating: 3.2,
                                     description: "This is a nice description",
                                     formattedPrice: "12,3€",
                                     kind: .software,
                                     trackName: "App Name",
                                     version: "3.4.1",
                                     screenshotUrls: [])
        
        static func respond(to request: URLRequest) throws -> Data {
            let result = SearchResult(resultCount: 1, results: [item])
            return try JSONEncoder().encode(result)
        }
    }
    
    // MARK: - Tests
    
    func test_SuccessfullyPerformingRequest() throws {
        // Given
        let client = NetworkingClient(mockRequester: MockSearchItemURLRequester.self)
        sut = SearchResultsRepository(client: client)
        
        // When
        let publisher = sut.loadResults(matching: "hamburguer")
        let result = try XCTUnwrap(try awaitCompletion(of: publisher).first?.first)
        
        // Then
        let item = MockSearchItemURLRequester.item
        assertEqualItem(result: result, expected: item)
    }
 
    func test_FailsWhenEncounteringError() throws {
        // Given
        let client = NetworkingClient(mockRequester: MockErrorURLResponder.self)
        sut = SearchResultsRepository(client: client)
        
        // When
        let publisher = sut.loadResults(matching: "hamburguer")
        
        // Then
        XCTAssertThrowsError(try awaitCompletion(of: publisher))
    }
    
    private func assertEqualItem(result: SearchItem, expected: SearchItem, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(result.artworkUrl100, expected.artworkUrl100, file: file, line: line)
        XCTAssertEqual(result.averageUserRating, expected.averageUserRating, file: file, line: line)
        XCTAssertEqual(result.description, expected.description, file: file, line: line)
        XCTAssertEqual(result.formattedPrice, expected.formattedPrice, file: file, line: line)
        XCTAssertEqual(result.kind, expected.kind, file: file, line: line)
        XCTAssertEqual(result.trackName, expected.trackName, file: file, line: line)
        XCTAssertEqual(result.version, expected.version, file: file, line: line)
        XCTAssertEqual(result.screenshotUrls, expected.screenshotUrls, file: file, line: line)
    }
}

extension SearchItem {
    static func createItem(named: String = "App Name") -> SearchItem {
        SearchItem(artworkUrl100: URL(string: "https://www.google.es")!,
                   averageUserRating: 3.2,
                   description: "This is a nice description",
                   formattedPrice: "12,3€",
                   kind: .software,
                   trackName: named,
                   version: "3.4.1",
                   screenshotUrls: [])
    }
    
    class MockSearchItemURLRequester: MockURLRequester {
        static var response: SearchItem = createItem(named: "Hola")
        
        static func respond(to request: URLRequest) throws -> Data {
            let result = SearchResult(resultCount: 1, results: [response])
            return try JSONEncoder().encode(result)
        }
    }
}
