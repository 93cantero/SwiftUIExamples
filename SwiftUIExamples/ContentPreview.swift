//  Created by Cantero on 20/03/2021.

import SwiftUI

#if DEBUG
extension ColorScheme {
    var previewName: String {
        String(describing: self).capitalized
    }
}

extension ContentSizeCategory {
    static let smallestAndLarge = [ContentSizeCategory.small, ContentSizeCategory.accessibilityExtraLarge]

    var previewName: String {
        self == Self.smallestAndLarge.first ? "Small" : "Large"
    }
}


struct ComponentPreview<Component: View>: View {
    
    var component: Component
    var contentSizeCategories: [ContentSizeCategory] = ContentSizeCategory.smallestAndLarge

    var body: some View {
        ForEach(values: ColorScheme.allCases) { scheme in
            ForEach(values: contentSizeCategories) { category in
                self.component
                    .previewLayout(.sizeThatFits)
                    .background(Color(.systemBackground))
                    .colorScheme(scheme)
                    .environment(\.sizeCategory, category)
                    .previewDisplayName(
                        "\(scheme.previewName) + \(category.previewName)"
                    )
            }
        }
    }
}

extension View {
    func previewAsComponent() -> some View {
        ComponentPreview(component: self)
    }
}
#endif
