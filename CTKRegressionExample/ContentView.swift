import SwiftUI

struct ContentView: View {
  @ObservedObject var watcher = IdentityProvider()

  var body: some View {
    TokenView(tokens: $watcher.tokens)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
