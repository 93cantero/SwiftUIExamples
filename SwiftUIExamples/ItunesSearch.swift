// Created by Cantero on 29/03/2021.

import Foundation

typealias NetworkModel = Identifiable & Decodable & Hashable

struct SearchResult: Decodable {
    var resultCount: Int
    var results: [SearchItem]
}

enum SearchItemKind: String, Decodable {
    case software
}

struct SearchItem: NetworkModel {
    var id: UUID = UUID()
    
    var artworkUrl100: URL
    var averageUserRating: Double
    var description: String
    var formattedPrice: String
    var kind: SearchItemKind
    var trackName: String
    var version: String
    var screenshotUrls: [URL]
    
    enum CodingKeys: CodingKey {
        case artworkUrl100, averageUserRating, description, formattedPrice, kind, trackName, version, screenshotUrls
    }
}
