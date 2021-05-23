// Created by Cantero on 30/03/2021.

import Foundation

struct UserDefaultsKey {
    static let configuration : String = "Configuration"
}

enum Configuration {
    
    static var environment: AppEnvironment = {
        guard let configuration = Bundle.main.object(forInfoDictionaryKey: UserDefaultsKey.configuration) as? String,
            var env = AppEnvironment(rawValue: configuration)
            else { return AppEnvironment.production }
        
        return env
    }()
}
