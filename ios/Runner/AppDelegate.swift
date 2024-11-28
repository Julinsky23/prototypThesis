
import Flutter
import UIKit
import Intents

//main-class of iOS-App
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //registers automatically generated plugins
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

  //checks if transferred Siri-Shortcuts corresponds to the supported activities from list
  private func handleSiriShortcut(_ userActivity: NSUserActivity){
  let supportedActivities = [
  "com.thesis_prototyp.startWork",
  "com.thesis_prototyp.stopTimer",
  "com.thesis_prototyp.resetTimer"
  ]

  //checks if user activity is one of supported activities
  guard supportedActivities.contains(userActivity.activityType) else { return }
  guard let controller = window?.rootViewController as? FlutterViewController else { return }


  //creates Channel to send messages to Flutter
  let channel = FlutterMethodChannel(
  name: "com.thesis_prototyp.siri_shortcuts",
  binaryMessenger: controller.binaryMessenger
  )

  //Calls Flutter method "onSiriShortcut" & passes User activity
  channel.invokeMethod("onSiriShortcut", arguments: ["activityType": userActivity.activityType])
  }
}
