import Cocoa

class MainMenuController: NSObject {
  weak var appDelegate: AppDelegate?
  weak var dependencyContainer: DependencyContainer?
  weak var listContainerViewController: ApplicationListContainerViewController?
  weak var detailFeatureViewController: ApplicationDetailFeatureViewController?

  // MARK: - Actions

  @IBAction func openWindow(_ sender: Any?) {
    NSApplication.shared.activate(ignoringOtherApps: true)
    try? appDelegate?.applicationDelegateController?.loadApplication()?.showWindow(nil)
  }

  @IBAction func selectBackupDestination(_ sender: Any?) {
    dependencyContainer?.backupController.chooseDestination()
  }

  @IBAction func viewGeneral(_ sender: Any?) {
    let tab = ApplicationDetailFeatureViewController.Tab.general
    guard let segmentedControl = detailFeatureViewController?.segmentedControl else {
      return
    }
    if let index = ApplicationDetailFeatureViewController.Tab.allCases.firstIndex(of: tab) {
      segmentedControl.setSelected(true, forSegment: index)
    } else {
      segmentedControl.setSelected(true, forSegment: 0)
    }
    detailFeatureViewController?.changeTab(segmentedControl)
  }

  @IBAction func viewCustomize(_ sender: Any?) {
    let tab = ApplicationDetailFeatureViewController.Tab.customize
    guard let segmentedControl = detailFeatureViewController?.segmentedControl else {
      return
    }
    if let index = ApplicationDetailFeatureViewController.Tab.allCases.firstIndex(of: tab) {
      segmentedControl.setSelected(true, forSegment: index)
    } else {
      segmentedControl.setSelected(true, forSegment: 0)
    }
    detailFeatureViewController?.changeTab(segmentedControl)
  }

  @IBAction func sortByName(_ sender: Any?) {
    guard let segmentControl = listContainerViewController?.sortViewController.segmentedControl else { return }
    segmentControl.setSelected(true, forSegment: 0)
    listContainerViewController?.sortViewController.didChangeSort(segmentControl)
  }

  @IBAction func sortBySynced(_ sender: Any?) {
    guard let segmentControl = listContainerViewController?.sortViewController.segmentedControl else { return }
    segmentControl.setSelected(true, forSegment: 1)
    listContainerViewController?.sortViewController.didChangeSort(segmentControl)
  }

  @IBAction func search(_ sender: Any?) {
    listContainerViewController?.searchViewController.searchField.becomeFirstResponder()
  }

  @IBAction func performBackup(_ sender: Any?) {
    guard let windowFactory = dependencyContainer?.windowFactory else { return }

    guard let backupDestination = UserDefaults.standard.syncaliciousUrl else {
      let message = NSLocalizedString("You need to pick a backup destination before you can make a backup.",
                                      comment: "")
      let alert = windowFactory.createAlert(with: message)
      alert.runModal()
      return
    }
    do {
      try dependencyContainer?.backupController.initializeBackup(to: backupDestination)
    } catch let error {
      let alert = windowFactory.createAlert(error: error)
      alert.runModal()
    }
  }
}
