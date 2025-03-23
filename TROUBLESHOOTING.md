# Troubleshooting Guide

This guide provides solutions for common issues you might encounter when working with the iOS-Flutter Communication Prototype.

## Connection Issues

### Method Channel Not Responding

**Symptoms:**
- Flutter app freezes when trying to communicate with iOS
- Method calls timeout or never return

**Solutions:**
1. Verify that method channel names match exactly on both the Flutter and iOS sides:
   ```dart
   // Flutter side
   static const MethodChannel _methodChannel = MethodChannel('com.zanis.ios_communication/method');
   ```
   
   ```swift
   // iOS side
   methodChannel = FlutterMethodChannel(name: "com.zanis.ios_communication/method", binaryMessenger: controller.binaryMessenger)
   ```

2. Check that your method handler is properly set up in AppDelegate:
   ```swift
   methodChannel?.setMethodCallHandler { [weak self] (call, result) in
     // Handler code here
   }
   ```

3. Make sure you're calling the method from the main thread in Flutter:
   ```dart
   await _methodChannel.invokeMethod('startRandomIntPerSecond');
   ```

### Event Channel Not Receiving Data

**Symptoms:**
- No data is being received from iOS
- Event channel listener doesn't fire

**Solutions:**
1. Verify that the event channel is properly registered on both sides:
   ```dart
   // Flutter side
   static const EventChannel _eventChannel = EventChannel('com.zanis.ios_communication/event');
   ```
   
   ```swift
   // iOS side
   eventChannel = FlutterEventChannel(name: "com.zanis.ios_communication/event", binaryMessenger: controller.binaryMessenger)
   ```

2. Check that your `StreamHandler` is properly implemented and set:
   ```swift
   let streamHandler = RandomIntStreamHandler()
   eventChannel?.setStreamHandler(streamHandler)
   ```

3. Ensure that you're adding the event sink to the right thread:
   ```swift
   DispatchQueue.main.async {
     self.eventSink?(data)
   }
   ```

4. Verify your subscription in Flutter:
   ```dart
   _eventSubscription = _eventChannel.receiveBroadcastStream().listen(
     (dynamic event) {
       // Handle event
     },
     onError: (dynamic error) {
       // Handle error
     },
   );
   ```

## Data Issues

### Data Corruption

**Symptoms:**
- Received data has incorrect types or values
- App crashes when trying to parse received data

**Solutions:**
1. Make sure data types match on both sides:
   ```swift
   // iOS side - sending an integer
   eventSink([
     "randomInt": randomInt, // Int
     "timestamp": timestamp  // Int
   ])
   ```
   
   ```dart
   // Flutter side - expecting an integer
   final response = IosCommunicationResponseModel(
     randomInt: event['randomInt'] as int,
     timestamp: event['timestamp'] as int,
   );
   ```

2. Add type checking and error handling:
   ```dart
   if (event is Map && event.containsKey('randomInt') && event.containsKey('timestamp')) {
     try {
       final response = IosCommunicationResponseModel(
         randomInt: event['randomInt'] as int,
         timestamp: event['timestamp'] as int,
       );
       // Process response
     } catch (e) {
       LoggerHelper.debugLog('Error parsing data: $e');
     }
   }
   ```

3. Check for memory issues on the iOS side that might corrupt data:
   ```swift
   // Use weak self to prevent memory leaks
   timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
     guard let self = self, let eventSink = self.eventSink else { return }
     // Rest of the code
   }
   ```

## Integration Issues

### Flutter Plugin Conflicts

**Symptoms:**
- Build errors when compiling the app
- Runtime crashes related to plugin initialization

**Solutions:**
1. Check for conflicting plugin versions in `pubspec.yaml` and update as needed:
   ```yaml
   dependencies:
     flutter_bloc: ^8.0.0  # Make sure versions are compatible
   ```

2. Run `flutter clean` followed by `flutter pub get` to refresh dependencies

3. Update CocoaPods on the iOS side:
   ```bash
   cd ios && pod update && cd ..
   ```

### iOS Build Errors

**Symptoms:**
- iOS build fails with compiler errors
- Xcode shows errors in Swift code

**Solutions:**
1. Make sure your iOS deployment target is set correctly:
   ```ruby
   # In Podfile
   platform :ios, '12.0'
   ```

2. Check Swift version compatibility:
   ```bash
   # In terminal
   xcrun swift --version
   ```

3. Clean the build folder in Xcode (Cmd+Shift+K) and try building again

## Performance Issues

### Slow Response Times

**Symptoms:**
- Delay between iOS data generation and Flutter UI update
- UI freezes when receiving data

**Solutions:**
1. Implement debouncing for high-frequency updates:
   ```dart
   // Use a throttled stream instead of passing every event
   _eventSubscription = _eventChannel.receiveBroadcastStream()
     .throttleTime(const Duration(milliseconds: 100))
     .listen(/* ... */);
   ```

2. Move heavy processing off the main thread on iOS:
   ```swift
   DispatchQueue.global(qos: .userInitiated).async {
     // Do heavy processing here
     let result = self.processData()
     
     DispatchQueue.main.async {
       // Send result to Flutter
       self.eventSink?(result)
     }
   }
   ```

3. Optimize the Flutter UI to handle frequent updates efficiently:
   ```dart
   // Use const widgets where possible
   const MyWidget(),
   
   // Implement proper shouldRebuild methods in custom widgets
   @override
   bool shouldRebuild(covariant oldWidget) {
     return data != oldWidget.data;
   }
   ```

## Debugging Tips

### Method Channel Debugging

To debug method channel calls:
```dart
try {
  final result = await _methodChannel.invokeMethod('myMethod');
  LoggerHelper.debugLog('Method call success: $result');
} catch (e) {
  LoggerHelper.errorLog('Method call failed: $e');
}
```

### Event Channel Debugging

To debug event channel data:
```dart
_eventSubscription = _eventChannel.receiveBroadcastStream().listen(
  (dynamic event) {
    LoggerHelper.debugLog('Received event: $event');
    // Handle event
  },
  onError: (dynamic error) {
    LoggerHelper.errorLog('Event error: $error');
    // Handle error
  },
);
```

### iOS Debugging

To log information from Swift:
```swift
print("Debug: \(randomInt) at time \(timestamp)")
```

For more complex debugging, use Xcode's Console and Breakpoints to inspect variables and execution flow.

## Still Stuck?

If you're still experiencing issues:

1. Check the Flutter and iOS documentation on platform channels:
   - [Flutter Platform Channels](https://flutter.dev/docs/development/platform-integration/platform-channels)
   - [iOS Swift Integration](https://flutter.dev/docs/development/platform-integration/ios/swift)

2. Look for similar issues on Stack Overflow or the Flutter GitHub repository

3. Try creating a minimal reproduction of the issue to isolate the problem 