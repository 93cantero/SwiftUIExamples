//  Created by Cantero on 20/03/2021.

import SwiftUI

struct MenuRow: View {
    
    var item: MenuItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.rawValue)
            Text(item.description)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .background(Color(.systemBackground))
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
