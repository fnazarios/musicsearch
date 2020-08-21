import UIKit

protocol SearchMusicDisplay: AnyObject {
    func reload(data: [Music])
}

final class SearchMusicViewController: ViewController<SearchMusicInteracting, UIView> {
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Artist"
        searchController.showsSearchResultsController = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(SearchMusicCell.self, forCellReuseIdentifier: String(describing: SearchMusicCell.self))
        return tableView
    }()
    
    private var dataSource: TableViewHandler<Music, SearchMusicCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func buildViewHierarchy() {
        view.addSubview(tableView)
        navigationItem.searchController = searchController
    }
    
    public override func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    public override func configureViews() {
        title = "Music Search"
    }
}

// MARK: SearchMusicDisplay
extension SearchMusicViewController: SearchMusicDisplay {
    func reload(data: [Music]) {
        dataSource = TableViewHandler(data: data, cellType: SearchMusicCell.self, configureCell: { _, model, cell in
            cell.configure(with: model)
        })
        
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}

// MARK: Search Delegate
extension SearchMusicViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        interactor.searh(term: searchBar.text)
    }
}
