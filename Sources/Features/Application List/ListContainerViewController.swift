import Cocoa
import Family

class ListContainerViewController: FamilyViewController {
  let listViewController: ApplicationListItemViewController
  let searchViewController: ListSearchViewController
  let sortViewController: ListSortViewController

  init(listViewController: ApplicationListItemViewController,
       searchViewController: ListSearchViewController,
       sortViewController: ListSortViewController) {
    self.listViewController = listViewController
    self.searchViewController = searchViewController
    self.sortViewController = sortViewController
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View life cycle

  override func loadView() {
    super.loadView()
    view = OpaqueView()
    view.autoresizingMask = [.width]
    view.autoresizesSubviews = true
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    body {
      add(searchViewController)
        .padding(.init(top: 10, left: 10, bottom: 0, right: 10))
      add(sortViewController)
        .padding(.init(top: 10, left: 10, bottom: 0, right: 10))
      add(listViewController, view: { $0.collectionView })
        .margin(.init(top: 0, left: 10, bottom: 10, right: 10))
    }
  }
}
