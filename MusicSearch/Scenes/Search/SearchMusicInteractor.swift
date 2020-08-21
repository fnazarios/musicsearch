import Foundation
import Combine

protocol SearchMusicInteracting {
    func searh(term: String?)
}

final class SearchMusicInteractor: SearchMusicInteracting {
    var searchSubject = PassthroughSubject<String?, Never>()
    
    private let service: SearchMusicServicing
    private let presenter: SearchMusicPresenting
    
    private var cancellables = Set<AnyCancellable>()
    
    init(service: SearchMusicServicing, presenter: SearchMusicPresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func searh(term: String?) {
        guard let term = term else {
            return
        }
        
        service.search(term: term) { result in
            switch result {
            case let .success(result):
                self.presenter.didReceive(result: result)
            case  let .failure(error):
                self.presenter.didReceive(failure: error)
            }
        }
    }
}
