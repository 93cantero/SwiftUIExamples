// Created by Cantero on 06/06/2021.

import SwiftUI

enum ModalOffset: Double {
    case oneThird = 0.33333
    case twoThirds = 0.66666
    case aFourth = 0.25
}

enum ModalState: CGFloat {
    
    case closed, partiallyRevealed, open
    
    func offsetFromTop() -> CGFloat {
        switch self {
        case .closed:
            return UIScreen.main.bounds.height
        case .partiallyRevealed:
            return UIScreen.main.bounds.height * 1/4
        case .open:
            return 0
        }
    }
}

struct Modal {
    var position: ModalState  = .closed
    var dragOffset: CGSize = .zero
    var content: AnyView?
}
