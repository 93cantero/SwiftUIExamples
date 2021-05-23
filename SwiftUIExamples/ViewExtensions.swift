// Created by Cantero on 14/04/2021.

import SwiftUI

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.onTapGesture(perform: UIApplication.shared.endEditing)
    }
}
