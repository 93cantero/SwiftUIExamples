// Created by Cantero on 05/08/2021.

import SwiftUI

struct PriceView: View {
    
    var price: String = "283"
    @State var decimals: String = "83"
    @State var addition: Bool = false
        
    var body: some View {
        HStack(alignment: .top) {
            Text("\(addition ? "+" : "")\(price)")
                .font(.title)
                .bold() +
            Text(",\(decimals)")
                .font(.callout)
                .bold()
                .baselineOffset(8) +
            Text("US$")
                .font(.callout)
                .bold()
                .baselineOffset(8)
        }
        .foregroundColor(.secondary)
        .transformEnvironment(\.sizeCategory) { value in
            value = ContentSizeCategory.medium
        }
    }
}


struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView()
            .previewAsSeparateColorSchemes()
    }
}
