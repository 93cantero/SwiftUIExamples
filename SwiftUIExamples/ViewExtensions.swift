// Created by Cantero on 14/04/2021.

import SwiftUI

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.onTapGesture(perform: UIApplication.shared.endEditing)
    }
    
    func onDragGesture(_ action: @escaping (DragGesture.Value) -> Void) -> some View {
        self.gesture(DragGesture().onChanged(action))
    }
}
