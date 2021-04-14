// Created by Cantero on 29/03/2021.

import Foundation
import Combine

extension JSONDecoder {
    static let useDefaultKeys: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

extension Publisher where Output == Data {
    
    func decode<T: Decodable>(as type: T.Type = T.self,
                              using decoder: JSONDecoder = .useDefaultKeys) -> Publishers.Decode<Self, T, JSONDecoder> {
        decode(type: type, decoder: decoder)
    }
}

extension Publisher {
    
    func validate(using validator: @escaping (Output) throws -> Void) -> Publishers.TryMap<Self, Output> {
        tryMap { output in
            try validator(output)
            return output
        }
    }
}

extension URLSession.DataTaskPublisher {
    
    func validateStatusCode(in range: ClosedRange<Int>) -> Publishers.TryMap<Self, Output> {
        validate { (data, response) in
            guard let response = response as? HTTPURLResponse, range.contains(response.statusCode) else {
                throw HTTPError.statusCode
            }
        }
    }
}
