// Created by Cantero on 14/04/2021.

import SwiftUI

extension ScrollView {
    func dismissKeyboardOnDrag() -> some View {
        self.gesture(DragGesture()
                        .onChanged { _ in
                            UIApplication.shared.endEditing()
                        })
    }
}
