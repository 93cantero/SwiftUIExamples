// Created by Cantero on 30/03/2021.

import Foundation

struct UserDefaultsKey {
    static let configuration : String = "Configuration"
}

struct Configuration {
    
    static var environment: Environment = {
        guard let configuration = Bundle.main.object(forInfoDictionaryKey: UserDefaultsKey.configuration) as? String,
            var env = Environment(rawValue: configuration)
            else { return Environment.production }
        
        return env
    }()
}
