import Foundation

struct Node: Identifiable {
  let id = UUID()
  let title: String
  let children: [Node]?
}
