import XCTest
import Combine
@testable import MusicSearch

class SearchMusicServiceTests: XCTestCase {

    private var cancellable = Set<AnyCancellable>()
    
    func testShouldReturnASuccessSearchMusic() {
        let expectation = XCTestExpectation(description: "testShouldReturnASuccessSearchMusic")
        
        let mock = NetworkSuccessMock()
        mock.result = SearchResult(results: [Music(kind: MusicKind.musicVideo, artistId: 1, collectionId: 1, trackId: 1, artistName: "Jose da Silva", collectionName: "Jose da Silva Collection", trackName: "Dancando com Jose", trackTimeMillis: 124, artistViewUrl: "")], resultCount: 1)
        
        let service = SearchMusicService(network: mock)
        service.search(term: "Jose da Silva") { result in
            switch result {
            case .success(let search):
                XCTAssertTrue(search.resultCount == 1)
                XCTAssertTrue(search.results.first?.artistName == "Jose da Silva")
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}

final class NetworkSuccessMock: Networking {
    var result: SearchResult?
    
    func dataTask<T>(with url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        completion(.success(result as! T))
    }
}
