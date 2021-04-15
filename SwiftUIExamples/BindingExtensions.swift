// Created by Cantero on 14/04/2021.

import SwiftUI

#if DEBUG
extension Binding {
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(get: { value }, set: { value = $0 })
    }
}
#endif
