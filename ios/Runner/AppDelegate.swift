import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private var methodChannel: FlutterMethodChannel?
  private var eventChannel: FlutterEventChannel?
  private var eventSink: FlutterEventSink?
  private var timer: Timer?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    
    // Set up method channel
    methodChannel = FlutterMethodChannel(
      name: "com.zanis.ios_communication/method",
      binaryMessenger: controller.binaryMessenger)
    
    methodChannel?.setMethodCallHandler { [weak self] (call, result) in
      guard let self = self else { return }
      
      switch call.method {
      case "startRandomIntPerSecond":
        self.startRandomIntPerSecond()
        result(nil)
      case "stopRandomIntPerSecond":
        self.stopRandomIntPerSecond()
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    
    // Set up event channel
    eventChannel = FlutterEventChannel(
      name: "com.zanis.ios_communication/event",
      binaryMessenger: controller.binaryMessenger)
    
    let streamHandler = RandomIntStreamHandler()
    streamHandler.onListen = { [weak self] sink in
      self?.eventSink = sink
    }
    streamHandler.onCancel = { [weak self] in
      self?.eventSink = nil
    }
    
    eventChannel?.setStreamHandler(streamHandler)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func startRandomIntPerSecond() {
    // Stop any existing timer
    stopRandomIntPerSecond()
    
    // Start a new timer that fires every second
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
      guard let self = self, let eventSink = self.eventSink else { return }
      
      // Generate a random number
      let randomInt = self.getRandomIntPerSecond()
      let timestamp = Int(Date().timeIntervalSince1970 * 1000)
      
      // Send the random number to Flutter
      eventSink([
        "randomInt": randomInt,
        "timestamp": timestamp
      ])
    }
    
    // This makes sure the timer is running on the main thread
    RunLoop.main.add(timer!, forMode: .common)
  }
  
  private func stopRandomIntPerSecond() {
    timer?.invalidate()
    timer = nil
  }
  
  private func getRandomIntPerSecond() -> Int {
    // Generate a random integer between 0 and 1000
    return Int.random(in: 0...1000)
  }
}

// Stream handler for the event channel
class RandomIntStreamHandler: NSObject, FlutterStreamHandler {
  var onListen: ((@escaping FlutterEventSink) -> Void)?
  var onCancel: (() -> Void)?
  
  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    onListen?(events)
    return nil
  }
  
  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    onCancel?()
    return nil
  }
}
