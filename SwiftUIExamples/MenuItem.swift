//  Created by Cantero on 20/03/2021.

import SwiftUI

enum MenuItem: String, Identifiable, CaseIterable {
    case first = "MENU_FIRST_ITEM_TITLE"
    case appRow = "MENU_APP_ROW_ITEM_TITLE"
    case purchase = "PURCHASE_APP_ROW_TITLE"
    
    var id: String { return rawValue }
    
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
    
    var isModal: Bool {
        self == .purchase
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .appRow: ItunesSearchView()
        case .first: MenuDetail()
        case .purchase: PurchaseView()
        }
    }
    
    var description: String {
        switch self {
        case .first: return "MENU_FIRST_ITEM_DESCRIPTION"
        case .appRow: return "MENU_APP_ROW_ITEM_DESCRIPTION"
        case .purchase: return "PURCHASE_APP_ROW_DESCRIPTION"
        }
    }
}
