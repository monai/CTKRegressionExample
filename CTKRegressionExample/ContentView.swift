import SwiftUI

struct ContentView: View {
  @ObservedObject var identityProvider = IdentityProvider()

  var body: some View {
    TokenView(tokens: $identityProvider.tokens)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
