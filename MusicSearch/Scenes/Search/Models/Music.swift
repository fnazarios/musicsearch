import Foundation

enum MusicKind: String, Decodable {
    case musicVideo = "music-video"
}

struct Music: Decodable {
    let kind: MusicKind
    let artistId: Int
    let trackId: Int
    let artistName: String
    let trackName: String
    let trackTimeMillis: Int?
    let artistViewUrl: String
    let artwork: String
    let collectionId: Int?
    let collectionName: String?
    
    enum CodingKeys: String, CodingKey {
        case kind
        case artistId
        case trackId
        case artistName
        case trackName
        case trackTimeMillis
        case artistViewUrl
        case artwork = "artworkUrl100"
        case collectionId
        case collectionName
    }
}
