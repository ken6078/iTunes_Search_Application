//
//  Artist.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/13.
//

import Foundation

// MARK: - ArtistResult
struct ArtistResult: Codable {
    let resultCount: Int
    let results: [Artist]
}

// MARK: - Artist
struct Artist: Codable, Identifiable {
    let id: Int
    let wrapperType: String
    let artistType: String
    var artistName: String
    let artistLinkURL: String

    enum CodingKeys: String, CodingKey {
        case wrapperType, artistType, artistName
        case artistLinkURL = "artistLinkUrl"
        case id = "artistId"
    }
}
