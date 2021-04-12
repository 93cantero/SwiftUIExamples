//  Created by Cantero on 20/03/2021.

import SwiftUI

struct MenuRow: View {
    
    var item: MenuItem
    
    var body: some View {
        VTitleAndDescriptionView(name: item.rawValue,
                                 description: item.description)
    }
}

#if DEBUG
struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuRow(item: .first)
                .previewAsComponent()
        }
    }
}
#endif
