// Created by Cantero on 30/03/2021.

import Foundation

struct InvalidEndpointError<K: EndpointType, R: Decodable>: Error {
    var endpoint: Endpoint<K, R>
}

enum HTTPError: LocalizedError {
    case statusCode
}
