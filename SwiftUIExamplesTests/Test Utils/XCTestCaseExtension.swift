// Created by Cantero on 15/04/2021.
import XCTest
import Combine

enum AwaitError: Error {
    case uncompletedExpectation(XCTestExpectation)
}

extension XCTestCase {
    func awaitCompletion<T: Publisher>(of publisher: T,
                                       expectedPublishedValues: UInt? = nil,
                                       timeout: TimeInterval = 10,
                                       description: String = "Awaiting publisher completion",
                                       file: StaticString = #file,
                                       line: UInt = #line,
                                       actions: (() -> Void)? = nil) throws -> [T.Output] {
        
        let expectation = self.expectation(description: description)

        var result: Result<[T.Output], Error>? = .failure(AwaitError.uncompletedExpectation(expectation))
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
                if let values = expectedPublishedValues, output.count == values {
                    result = .success(output)
                    expectation.fulfill()
                }
            }
        )

        actions?()
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(result, "Awaited publisher did not produce any output",
                                            file: file,
                                            line: line)

        return try unwrappedResult.get()
    }
}

// MARK: - Assert Equal

extension XCTestCase {
    
    func assertEqual<T: Hashable>(lhs: T, rhs: T, file: StaticString = #filePath, line: UInt = #line) throws {
        let lhsChildren = Mirror(reflecting: lhs).children
        let rhsChildren = Mirror(reflecting: rhs).children
        XCTAssertEqual(lhsChildren.count, rhsChildren.count, file: file, line: line)
        
        let lhsHashableChildren = lhsChildren.compactMap { tuple -> (String?, AnyHashable)? in
            guard let value = tuple.value as? AnyHashable else { return nil }
            return (tuple.label, value)
        }
        for case let (label?, value) in lhsHashableChildren {
            let tuple = try XCTUnwrap(rhsChildren.first { $0.label == label })
            XCTAssertEqual(value, tuple.value as? AnyHashable)
        }
    }
}
