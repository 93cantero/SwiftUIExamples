// Created by Cantero on 11/04/2021.
import SwiftUI
import Kingfisher

var cache: Set<String> = .init()

struct CommonImage: View {
    var url: URL?
    
    var body: some View {
        Group {
            if let url = self.url {
                KFImage.url(url)
                    .placeholder({ Color(UIColor.secondarySystemBackground) })
                    .cacheMemoryOnly()
                    .resizable()
                    .cancelOnDisappear(true)
                    .fade(duration: 0.25)
                    .loadImmediately()
            } else {
                Color(UIColor.secondarySystemBackground)
            }
        }
        .animation(.easeIn(duration: 0.25))

    }
}
