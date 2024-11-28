
import Flutter
import UIKit
import Intents

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
  _ application: UIApplication,
  continue userActivity: NSUserActivity,
  restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
  ) -> Bool {
        handleSiriShortcut(userActivity)
        return true
  }

  private func handleSiriShortcut(_ userActivity: NSUserActivity){
  let supportedActivities = [
  "com.vamos.startWork",
  "com.vamos.stopTimer",
  "com.vamos.resetTimer"
  ]

  guard supportedActivities.contains(userActivity.activityType) else { return }
  guard let controller = window?.rootViewController as? FlutterViewController else { return }

  let channel = FlutterMethodChannel(
  name: "com.vamos.siri_shortcuts",
  binaryMessenger: controller.binaryMessenger
  )
  channel.invokeMethod("onSiriShortcut", arguments: ["activityType": userActivity.activityType])
  }
}
