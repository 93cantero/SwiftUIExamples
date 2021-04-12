//  Created by Cantero on 20/03/2021.

import Foundation

enum MenuItem: String, Identifiable, CaseIterable {
    case first = "First Item"
    case appRow = "Itunes Apps"
    
    var id: String { return rawValue }
    
    var description: String {
        switch self {
        case .first: return "This is the first item of the list"
        case .appRow: return "Displays a list of the apps"
        }
    }
}
