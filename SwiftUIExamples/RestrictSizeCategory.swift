// Created by Cantero on 14/04/2021.

import SwiftUI

fileprivate struct RestrictSizeCategory: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory

    @ViewBuilder
    func body(content: Content) -> some View {
            if sizeCategory > ContentSizeCategory.extraExtraExtraLarge {
                content.transformEnvironment(\.sizeCategory) { value in
                    value = ContentSizeCategory.extraExtraExtraLarge
                }
            } else {
                content
            }
    }
}

extension View {
    func restrictSizeCategory() -> some View {
        return modifier(RestrictSizeCategory())
    }
}
