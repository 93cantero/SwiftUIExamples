// Created by Cantero on 29/03/2021.

import Foundation

enum AppEnvironment: String {
    case production
    
    var host: URLHost {
        return .production
    }
    
    var scheme: Scheme {
        return .https
    }
}

// MARK: Custom String Convertible
extension AppEnvironment : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String {
        "PRODUCTION"
    }
    
    var debugDescription: String {
        return "\(self.description): \(self.host.rawValue)"
    }
}
