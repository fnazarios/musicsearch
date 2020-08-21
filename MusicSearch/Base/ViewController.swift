import UIKit

public protocol ViewConfiguration: AnyObject {
    func bindInteractor()
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
    func buildLayout()
}

extension ViewConfiguration {
    public func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    public func configureViews() { }
}

open class ViewController<Interactor, V: UIView>: UIViewController, ViewConfiguration {
    public let interactor: Interactor
    public var rootView = V()
    
    public init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        bindInteractor()
        buildLayout()
    }
    
    override open func loadView() {
        view = rootView
    }
    
    open func bindInteractor() { }
    
    open func buildViewHierarchy() { }
    
    open func setupConstraints() { }
    
    open func configureViews() { }
}

public extension ViewController where Interactor == Void {
    convenience init(_ interactor: Interactor = ()) {
        self.init(interactor: interactor)
    }
}
