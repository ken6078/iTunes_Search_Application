// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let songs = try? JSONDecoder().decode(Songs.self, from: jsonData)

import Foundation

// MARK: - Songs
struct SongResult: Codable {
    let resultCount: Int
    let results: [Song]
}

// MARK: - Song
struct Song: Codable, Identifiable {
    let wrapperType, kind: String
    let id: Int
    let artistID: Int
    let artistName: String
    let collectionName: String
    let collectionCensoredName: String?
    let trackName: String
    let trackCensoredName: String
    let artistViewURL: String?
    let collectionViewURL: String
    let trackViewURL: String?
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Double?
    var releaseDate: String
    let collectionExplicitness, trackExplicitness: String
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int
    let country, currency, primaryGenreName: String
    let isStreamable: Bool?
    let collectionArtistID: Int?
    let collectionArtistName: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case id = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
        case collectionArtistID = "collectionArtistId"
        case collectionArtistName
    }
    
    init(wrapperType: String, kind: String, id: Int, artistID: Int, artistName: String, collectionName: String, collectionCensoredName: String?, trackName: String, trackCensoredName: String, artistViewURL: String?, collectionViewURL: String, trackViewURL: String?, previewURL: String, artworkUrl30: String, artworkUrl60: String, artworkUrl100: String, collectionPrice: Double?, trackPrice: Double?, releaseDate: String, collectionExplicitness: String, trackExplicitness: String, discCount: Int?, discNumber: Int?, trackCount: Int?, trackNumber: Int?, trackTimeMillis: Int, country: String, currency: String, primaryGenreName: String, isStreamable: Bool?, collectionArtistID: Int?, collectionArtistName: String?) {
        self.wrapperType = wrapperType
        self.kind = kind
        self.id = id
        self.artistID = artistID
        self.artistName = artistName
        self.collectionName = collectionName
        self.collectionCensoredName = collectionCensoredName
        self.trackName = trackName
        self.trackCensoredName = trackCensoredName
        self.artistViewURL = artistViewURL
        self.collectionViewURL = collectionViewURL
        self.trackViewURL = trackViewURL
        self.previewURL = previewURL
        self.artworkUrl30 = artworkUrl30
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl100
        self.collectionPrice = collectionPrice
        self.trackPrice = trackPrice
        self.releaseDate = releaseDate
        self.collectionExplicitness = collectionExplicitness
        self.trackExplicitness = trackExplicitness
        self.discCount = discCount
        self.discNumber = discNumber
        self.trackCount = trackCount
        self.trackNumber = trackNumber
        self.trackTimeMillis = trackTimeMillis
        self.country = country
        self.currency = currency
        self.primaryGenreName = primaryGenreName
        self.isStreamable = isStreamable
        self.collectionArtistID = collectionArtistID
        self.collectionArtistName = collectionArtistName
    }
    
    static func example() -> Song {
        Song(wrapperType: "track", kind: "song", id: 1480229675, artistID: 300117743, artistName: "周杰倫 & 五月天 阿信", collectionName: "說好不哭 - Single", collectionCensoredName: "說好不哭 - Single", trackName: "說好不哭", trackCensoredName: "說好不哭", artistViewURL: "https://music.apple.com/tw/artist/%E5%91%A8%E6%9D%B0%E5%80%AB/300117743?uo=4", collectionViewURL: "https://music.apple.com/tw/album/%E8%AA%AA%E5%A5%BD%E4%B8%8D%E5%93%AD/1480229674?i=1480229675&uo=4", trackViewURL: "https://music.apple.com/tw/album/%E8%AA%AA%E5%A5%BD%E4%B8%8D%E5%93%AD/1480229674?i=1480229675&uo=4", previewURL: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/09/56/a3/0956a3ba-1d87-1297-eaa2-6520a9297375/mzaf_9451698682107745612.plus.aac.p.m4a", artworkUrl30: "https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/73/8c/2a/738c2a6b-a042-b475-04f0-56dff035c292/4711448407219.jpg/30x30bb.jpg", artworkUrl60: "https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/73/8c/2a/738c2a6b-a042-b475-04f0-56dff035c292/4711448407219.jpg/60x60bb.jpg", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/73/8c/2a/738c2a6b-a042-b475-04f0-56dff035c292/4711448407219.jpg/100x100bb.jpg", collectionPrice: 30.00, trackPrice: 30.00, releaseDate: "2019-09-16T07:00:00Z", collectionExplicitness: "notExplicit", trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 1, trackNumber: 1, trackTimeMillis: 222333, country: "TWN", currency: "TWD", primaryGenreName: "國語流行樂", isStreamable: true, collectionArtistID: 618703099, collectionArtistName: "群星")
    }
}
