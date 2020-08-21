import Foundation
import Combine

enum NetworkError: Error {
    case notFound
    case badRequest
    case noData
    case decode(Error)
    case unknown
}

protocol Networking {
    func dataTask<T>(with url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable
}

final class Network: Networking {
  
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func dataTask<T>(with url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable {
        let task = self.session.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                if let body = data {
                    self.decode(data: body, completion: completion)
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.noData))
                    }
                }
            case 400:
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.badRequest))
                }
            case 404:
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.notFound))
                }
            default:
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unknown))
                }
            }
        }
        
        task.resume()
    }
    
    private func decode<T>(data: Data, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable {
        do {
            let decode = JSONDecoder()
            let decoded = try decode.decode(T.self, from: data)
            DispatchQueue.main.async {
                completion(.success(decoded))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.decode(error)))
            }
        }
    }
}
