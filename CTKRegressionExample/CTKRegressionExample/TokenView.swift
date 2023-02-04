import SwiftUI

struct TokenView: View {
  @Binding var tokens: [Node]

  var body: some View {
    List {
      OutlineGroup(tokens, children: \.children) { node in
        Text(node.title)
      }
    }
    .listStyle(.inset(alternatesRowBackgrounds: true))
  }
}

struct TokenView_Previews: PreviewProvider {
  static let node = Node(title: "com.apple.example.ctk", children: [
    Node(title: "John Appleseed Authentication", children: nil),
    Node(title: "John Appleseed Non-repudiation", children: nil),
  ])

  static var previews: some View {
    TokenView(tokens: .constant([node]))
  }
}
