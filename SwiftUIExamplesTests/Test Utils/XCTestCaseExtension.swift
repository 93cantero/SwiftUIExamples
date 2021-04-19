// Created by Cantero on 15/04/2021.
import XCTest
import Combine

extension XCTestCase {
    func awaitCompletion<T: Publisher>(of publisher: T,
                                       expectedPublishedValues: UInt = 1,
                                       timeout: TimeInterval = 10,
                                       description: String = "Awaiting publisher completion",
                                       file: StaticString = #file,
                                       line: UInt = #line) throws -> [T.Output] {
        
        let expectation = self.expectation(description: description)

        var result: Result<[T.Output], Error>? = .failure(MockError.fail)
        var output = [T.Output]()

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    result = .success(output)
                }
                expectation.fulfill()
            }, receiveValue: {
                output.append($0)
                if output.count == expectedPublishedValues {
                    result = .success(output)
                    expectation.fulfill()
                }
            }
        )

        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(result, "Awaited publisher did not produce any output",
                                            file: file,
                                            line: line)

        return try unwrappedResult.get()
    }
}
