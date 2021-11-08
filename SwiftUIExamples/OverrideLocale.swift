// Created by Cantero on 03/05/2021.

import SwiftUI

extension View {
    
    func translated(to locale: Locale) -> some View {
        self.environment(\.locale, locale)
    }
}
