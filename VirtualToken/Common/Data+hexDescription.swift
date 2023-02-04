import Foundation

extension Data {
  /// A hex encoded data
  var hexDescription: String {
    return reduce("") {$0 + String(format: "%02x", $1)}
  }
}
