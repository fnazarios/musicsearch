import Foundation
import Combine

protocol SearchMusicServicing {
    func search(term: String, completion: @escaping (Result<SearchResult, NetworkError>) -> Void)
}

final class SearchMusicService: SearchMusicServicing {
    private let network: Networking
    
    init(network: Networking = Network()) {
        self.network = network
    }
    
    func search(term: String, completion: @escaping (Result<SearchResult, NetworkError>) -> Void) {
        guard let url = makeURL(with: term) else {
            completion(.failure(NetworkError.badRequest))
            return
        }
        
        network.dataTask(with: url) { (result: Result<SearchResult, NetworkError>) in
            completion(result)
        }
    }
    
    func makeURL(with term: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "itunes.apple.com"
        urlComponents.path = "/search"
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "entity", value: "musicVideo")
        ]
     
        return urlComponents.url
    }
}
