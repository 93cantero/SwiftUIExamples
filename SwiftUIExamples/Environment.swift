// Created by Cantero on 29/03/2021.

import Foundation

enum Environment: String {
    case production
    
    var host: URLHost {
        return .production
    }
}

// MARK: Custom String Convertible
extension Environment : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String {
        "PRODUCTION"
    }
    
    var debugDescription: String {
        return "\(self.description): \(self.host.rawValue)"
    }
}
