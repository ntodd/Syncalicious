import Cocoa
import UserNotifications

class NotificationController {
  let iconController: IconController

  init(iconController: IconController) {
    self.iconController = iconController
  }

  func post(application: Application, text: String) {
    let content = UNMutableNotificationContent()
    content.subtitle = application.propertyList.bundleName
    content.body = text
    let url = iconController.pathForApplicationImage(application, identifier: application.propertyList.bundleIdentifier)
    if let url = url,
      let attachment = try? UNNotificationAttachment(identifier: application.propertyList.bundleIdentifier + "-image", url: url, options: nil) {
      content.attachments = [attachment]
    }

    let request = UNNotificationRequest(identifier: application.propertyList.bundleIdentifier, content: content, trigger: nil)
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request)
  }
}
