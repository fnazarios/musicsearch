import Foundation

struct SearchResult: Decodable {
    let results: [Music]
    let resultCount: Int
}
