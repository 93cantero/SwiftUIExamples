// Created by Cantero on 15/04/2021.
import Foundation

enum MockErrorURLResponder: MockURLRequester {
    static func respond(to request: URLRequest) throws -> Data {
        throw URLError(.badServerResponse)
    }
}
