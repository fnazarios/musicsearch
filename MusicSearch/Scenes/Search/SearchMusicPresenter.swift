import Foundation

protocol SearchMusicPresenting: AnyObject {
    var viewController: SearchMusicDisplay? { get set }
    
    func didReceive(result: SearchResult)
    func didReceive(failure: NetworkError)
}

final class SearchMusicPresenter: SearchMusicPresenting {
    weak var viewController: SearchMusicDisplay?
    
    func didReceive(result: SearchResult) {
        viewController?.reload(data: result.results)
    }
    
    func didReceive(failure: NetworkError) {
        
    }
}
