import Foundation
import CryptoTokenKit

class IdentityProvider: ObservableObject {
  @Published var tokens: [Node] = []

  private var watcher = TKTokenWatcher()

  init() {
    watcher.setInsertionHandler(insertionHandler)
  }

  private func insertionHandler(_ tokenID: String) {
    watcher.addRemovalHandler(removalHandler, forTokenID: tokenID)

    let identities = self.identities(for: tokenID)
    let token = Node(
      title: tokenID,
      children: identities.map({ Node(title: $0, children: nil) })
    )

    DispatchQueue.main.async {
      self.tokens.append(token)
    }
  }

  private func removalHandler(_ tokenID: String) {
    DispatchQueue.main.async {
      self.tokens.removeAll { node in
        node.title == tokenID
      }
    }
  }

  private func identities(for tokenID: String) -> [String] {
    let query: [CFString: Any] = [
      kSecClass: kSecClassIdentity,
      kSecAttrCanSign: true,
      kSecMatchLimit: kSecMatchLimitAll,
      kSecReturnRef: true,
      kSecAttrTokenID: tokenID,
    ]

    var items: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &items)
    if status == errSecItemNotFound {
//    NOTE: Unexpected errSecItemNotFound status for smartcard token on macOS Ventura.
      print("errSecItemNotFound", tokenID)
      return []
    }

    guard status == errSecSuccess else {
      fatalError("SecItemCopyMatching failure")
    }

    guard let secIdentities = items as? [SecIdentity] else {
      fatalError("Keychain item type is not SecIdentity")
    }

    return secIdentities.map { secIdentity in
      var secCertificate: SecCertificate?
      let status = SecIdentityCopyCertificate(secIdentity, &secCertificate)
      guard status == errSecSuccess, let secCertificate = secCertificate else {
        fatalError("SecIdentityCopyCertificate failure")
      }

      var commonName: CFString?
      SecCertificateCopyCommonName(secCertificate, &commonName)

      guard let commonName = commonName as? String else {
        fatalError("SecCertificateCopyCommonName failure")
      }

      return commonName
    }
  }
}
