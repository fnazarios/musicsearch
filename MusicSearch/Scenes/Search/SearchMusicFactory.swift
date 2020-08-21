import UIKit

final class SearchMusicFactory {
    static func make() -> UIViewController {
        let service: SearchMusicServicing = SearchMusicService()
        let presenter: SearchMusicPresenting = SearchMusicPresenter()
        let interactor: SearchMusicInteracting = SearchMusicInteractor(service: service, presenter: presenter)
        
        let viewController = SearchMusicViewController(interactor: interactor)
        presenter.viewController = viewController
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
