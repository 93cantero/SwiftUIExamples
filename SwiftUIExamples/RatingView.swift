// Created by Cantero on 05/04/2021.

import Foundation
import SwiftUI

private struct Constants {
    static let color = Color.orange
    static let maxStarCount = 5
    static let spacing: CGFloat = 4
}

private enum Star: String {
    case full = "star.fill"
    case halfFull = "star.leadinghalf.fill"
    case empty = "star"
}

struct RatingView: View {
    let rating: Float
    var spacing = Constants.spacing
    var color = Constants.color
    var maxNumOfStars = Constants.maxStarCount
    
    private var fullStarCount: Int {
        Int(rating)
    }
    private var emptyStarCount: Int {
        Int(max(0, Float(maxNumOfStars) - rating))
    }
    private var halfStarCount: Int {
        ((fullStarCount + emptyStarCount) < maxNumOfStars) ? 1 : 0
    }
    
    var body: some View {
        HStack(spacing: spacing) {
            addStars(count: fullStarCount, starKind: .full)
            addStars(count: halfStarCount, starKind: .halfFull)
            addStars(count: emptyStarCount, starKind: .empty)
        }
    }
    
    private func addStars(count: Int, starKind star: Star) -> some View {
        ForEach(0..<count, id: \.self) { _ in
            createStar(star)
        }
    }
        
    private func createStar(_ star: Star) -> some View {
        Image(systemName: star.rawValue)
            .resizable()
            .scaledToFit()
            .foregroundColor(color)
    }
}

#if DEBUG
struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RatingView(rating: 3)
                .frame(height: 30)
                .previewAsSeparateColorSchemes()

            RatingView(rating: 1.5)
                .frame(height: 30)

            RatingView(rating: 5)
                .frame(height: 30)
            
            RatingView(rating: 2.8)
                .frame(height: 30)
            
            RatingView(rating: 5.6, color: .green, maxNumOfStars: 10)
                .frame(height: 30)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
