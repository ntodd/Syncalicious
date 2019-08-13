import Cocoa
import Family

class DetailContainerViewController: FamilyViewController {
  let generalActionsViewController: GeneralActionsViewController
  let generalInfoViewController: GeneralInfoViewController
  let computersViewController: ComputerDetailItemViewController
  let applicationDetailViewController: ApplicationDetailItemViewController

  init(generalActionsViewController: GeneralActionsViewController,
       generalInfoViewController: GeneralInfoViewController,
       computersViewController: ComputerDetailItemViewController,
       applicationsDetailViewController: ApplicationDetailItemViewController) {
    self.generalActionsViewController = generalActionsViewController
    self.generalInfoViewController = generalInfoViewController
    self.computersViewController = computersViewController
    self.applicationDetailViewController = applicationsDetailViewController
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    super.loadView()
    view = OpaqueView()
    view.autoresizingMask = [.width]
    view.autoresizesSubviews = true
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    body(withDuration: 0) {
      add(applicationDetailViewController, view: { $0.collectionView })
        .margin(.init(top: 0, left: 30, bottom: 15, right: 30))
      add(generalInfoViewController)
        .margin(.init(top: 15, left: 30, bottom: 0, right: 30))
      add(generalActionsViewController)
      add(computersViewController, view: { $0.collectionView })
    }

    computersViewController.collectionView.backgroundColors = [NSColor.windowBackgroundColor]
  }
}
