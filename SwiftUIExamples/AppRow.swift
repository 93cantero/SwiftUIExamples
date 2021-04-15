// Created by Cantero on 31/03/2021.

import SwiftUI
import Combine

struct AppRow: View {
    @State var item: SearchItem
    
    var ratingStack: some View {
        HStack(alignment: .center, spacing: 6) {
            RatingView(rating: Float(item.averageUserRating))
                .frame(height: 12)
            Text(String(format: "(%.2f)", item.averageUserRating))
                .font(.caption2)
                .foregroundColor(Color(UIColor.secondaryLabel))
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                LogoImage(url: self.item.artworkUrl100)
                VStack(alignment: .leading, spacing: 8) {
                    VTitleAndDescriptionView(name: item.trackName, description: item.description)
                    ratingStack
                }
                Spacer()
            }
            
            buildImageColumns(maximum: 3, height: 260)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
    
    private func buildImageColumns(maximum: Int, height: CGFloat) -> some View {
        var urls = self.item.screenshotUrls
        if self.item.screenshotUrls.count > maximum {
            urls = Array(self.item.screenshotUrls[0..<maximum])
        }
        
        var columns: [GridItem] = []
        var items: [CommonImage] = []
        for url in urls {
            columns.append(GridItem(.flexible()))
            let image: CommonImage = CommonImage(url: url)
            items.append(image)
        }
        return LazyVGrid(columns: columns,
                         alignment: .center, spacing: 12) {
            ForEach(items, id: \.url) { item in
                item
                    .frame(height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
    }
}

//struct AppRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AppRow(item: SearchItem(artworkUrl100: <#T##URL#>, averageUserRating: <#T##Double#>, description: <#T##String#>, formattedPrice: <#T##String#>, kind: <#T##SearchItemKind#>, trackName: <#T##String#>, version: <#T##String#>, screenshotUrls: <#T##[URL]#>))
//            .frame(width: 375)
//            .previewAsComponent()
//    }
//}
