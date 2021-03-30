// Created by Cantero on 29/03/2021.

import Foundation

struct URLHost: RawRepresentable {
    var rawValue: String
}

extension URLHost {
    static var production: Self {
        URLHost(rawValue: "itunes.apple.com")
    }

    static var `default`: Self {
        return production
    }
}
