import XCTest
import Combine
@testable import MusicSearch

class NetworkTests: XCTestCase {
    func testShoulReturnSuccessRequest() {
        
    }
}

final class URLSessionSuccessMock: URLSessionContract {
    var mockData = """
        {
            "wrapperType":"track",
            "kind":"music-video",
            "artistId":1419227,
            "collectionId":939779719,
            "trackId":939779783,
            "artistName":"Beyoncé",
            "collectionName":"BEYONCÉ (More Only) - EP",
            "trackName":"1+1",
            "collectionCensoredName":"BEYONCÉ (More Only) - EP",
            "trackCensoredName":"1+1 (Live from Mrs. Carter Show World Tour)",
            "artistViewUrl":"https://music.apple.com/us/artist/beyonc%C3%A9/1419227?uo=4",
            "collectionViewUrl":"https://music.apple.com/us/music-video/1-1-live-from-mrs-carter-show-world-tour/939779783?uo=4",
            "trackViewUrl":"https://music.apple.com/us/music-video/1-1-live-from-mrs-carter-show-world-tour/939779783?uo=4",
            "previewUrl":"https://video-ssl.itunes.apple.com/itunes-assets/Video128/v4/b1/77/09/b177099e-8896-f8e8-fbd0-32a07043a198/mzvf_4178862957106535709.640x480.h264lc.U.p.m4v",
            "artworkUrl30":"https://is1-ssl.mzstatic.com/image/thumb/Video3/v4/e5/ab/42/e5ab42d9-ce31-160f-d5c7-668b9a0200a2/source/30x30bb.jpg",
            "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Video3/v4/e5/ab/42/e5ab42d9-ce31-160f-d5c7-668b9a0200a2/source/60x60bb.jpg",
            "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Video3/v4/e5/ab/42/e5ab42d9-ce31-160f-d5c7-668b9a0200a2/source/100x100bb.jpg",
            "collectionPrice":8.99,
            "trackPrice":1.99,
            "releaseDate":"2011-05-25T07:00:00Z",
            "collectionExplicitness":"explicit",
            "trackExplicitness":"notExplicit",
            "discCount":2,
            "discNumber":2,
            "trackCount":16,
            "trackNumber":7,
            "trackTimeMillis":287635,
            "country":"USA",
            "currency":"USD",
            "primaryGenreName":"Pop"
        }
    """.data(using: .utf8)
    
    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher {
        
        Future<(data: Data, response: URLResponse), Error> { promise in
            guard let url = URL(string: "https://itunes.apple.com/search?term=beyonce&entity=musicVideo") else {
                return
            }
            
            promise(.success((data: mockData, response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: []))))
        }.eraseToAnyPublisher()
    }
}
