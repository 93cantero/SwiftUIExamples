// Created by Cantero on 10/09/2021.

import SwiftUI

struct LineView: View {
    
    var body: some View {
        Rectangle()
            .frame(height: 0.5)
            .background(Color(UIColor.lightGray))
            .padding([.leading, .trailing])
    }
}

#if DEBUG
struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView()
    }
}
#endif
