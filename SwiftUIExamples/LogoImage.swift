// Created by Cantero on 11/04/2021.
import SwiftUI

/// A squared image that is clipped in a rounded rectangle shape
struct LogoImage: View {
    var url: URL?
    var sideLength: CGFloat = 50
    
    var body: some View {
        CommonImage(url: url)
            .frame(width: sideLength, height: sideLength, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
