// Created by Cantero on 31/03/2021.

import SwiftUI
import Combine

struct AppRow: View {
    @State var item: SearchItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .top) {
                LogoImage(url: self.item.artworkUrl100)
                VStack(alignment: .leading, spacing: 8) {
                    VTitleAndDescriptionView(name: item.trackName, description: item.description)
                    HStack(alignment: .center, spacing: 6) {
                        RatingView(rating: Float(item.averageUserRating))
                            .frame(height: 12)
                        Text(String(format: "%.2f", item.averageUserRating))
                            .font(.caption2)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                }
                .layoutPriority(1)
                Spacer()
            }
            
//            buildImageColumns(maximum: 3)
//                .frame(height: 220)
            
            LazyVGrid(columns: [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible())],
                      alignment: .center, spacing: 12) {
                CommonImage(url: self.item.screenshotUrls[0])
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .frame(height: 220)
                CommonImage(url: self.item.screenshotUrls[1])
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .frame(height: 220)
                CommonImage(url: self.item.screenshotUrls[2])
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .frame(height: 220)
            }
            .font(.body)
//            .animation(.easeIn)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
    
    func buildImageColumns(maximum: Int) -> some View {
        var urls = self.item.screenshotUrls
        if self.item.screenshotUrls.count >= maximum {
            urls = Array(self.item.screenshotUrls[1...maximum])
        }
        
        var columns: [GridItem] = []
        var items: [CommonImage] = []
        for url in urls {
            columns.append(GridItem(.flexible()))
            let image: CommonImage = CommonImage(url: url)
//                .clipShape(RoundedRectangle(cornerRadius: 5))
            items.append(image)
        }
        return LazyVGrid(columns: columns,
                         alignment: .center, spacing: 12) {
            ForEach(items, id: \.url) { item in
                item
                    .frame(height: 220)
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
