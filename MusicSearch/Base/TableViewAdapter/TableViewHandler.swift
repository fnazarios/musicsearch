import UIKit

public class TableViewHandler<T, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
    public typealias ConfigureCellHandler = (Int, T, Cell) -> Void
    public typealias CellIdentifier = (IndexPath, T) -> String
    public typealias ConfigureDidSelectRowHandler = (IndexPath, T) -> Void

    private var data: [T]
    private let cellType: Cell.Type
    private let configureCellHandler: ConfigureCellHandler
    private let cellIdentifier: CellIdentifier?

    private var configureDidSelectRowHandler: ConfigureDidSelectRowHandler?
    private var configureDidDeselectRowHandler: ConfigureDidSelectRowHandler?
 
    public init(
        data: [T],
        cellType: Cell.Type = Cell.self,
        configureCell: @escaping ConfigureCellHandler,
        configureDidSelectRow: ConfigureDidSelectRowHandler? = nil,
        configureDidDeselectRow: ConfigureDidSelectRowHandler? = nil
    ) {
        self.data = data
        self.cellType = cellType
        self.configureCellHandler = configureCell
        self.cellIdentifier = nil
        self.configureDidSelectRowHandler = configureDidSelectRow
        self.configureDidDeselectRowHandler = configureDidDeselectRow
        
        super.init()
    }
  
    public func didSelectRow(completion: @escaping ConfigureDidSelectRowHandler) {
        configureDidSelectRowHandler = completion
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: cellType)) as? Cell else {
            return UITableViewCell()
        }
        
        configureCellHandler(indexPath.row, data[indexPath.row], cell)
        
        return cell
    }
  
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configureDidSelectRowHandler?(indexPath, data[indexPath.row])
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        configureDidDeselectRowHandler?(indexPath, data[indexPath.row])
    }
}
