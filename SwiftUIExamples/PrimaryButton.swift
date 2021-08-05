// Created by Cantero on 24/07/2021.

import SwiftUI

fileprivate struct Primary: ViewModifier {

    @ViewBuilder
    func body(content: Content) -> some View {
        content.padding()
            .frame(minWidth: 250, minHeight: 44)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .restrictSizeCategory()
            .cornerRadius(8)
    }
}

extension Button {
    func primary() -> some View {
        self.modifier(Primary())
    }
}

/// PrimaryButton -
struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Hola") {
            print("Hola")
        }
        .primary()
        .padding()
        .previewAsComponent()
    }
}
