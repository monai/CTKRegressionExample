import AppKit
import CryptoTokenKit
import OSLog

class Token: TKSmartCardToken, TKTokenDelegate {

  init(smartCard: TKSmartCard, aid AID: Data?, tokenDriver: TKSmartCardTokenDriver) throws {
    let instanceID = "token_instance_id" // Fill in a unique persistent identifier of the token instance.
    super.init(smartCard: smartCard, aid:AID, instanceID:instanceID, tokenDriver: tokenDriver)
    // Insert code here to enumerate token objects and populate keychainContents with instances of TKTokenKeychainCertificate, TKTokenKeychainKey, etc.

    os_log("Token init")

    try smartCard.withSession {
      self.getTokens()
    }
  }

  func createSession(_ token: TKToken) throws -> TKTokenSession {
    os_log("Token createSession")

    return TokenSession(token:self)
  }

  func getTokens() {
    var items = [TKTokenKeychainItem]()

    let fileNames = ["john", "jane"]
    for fileName in fileNames {
      guard let url = Bundle.main.url(forResource: fileName, withExtension: "der") else {
        continue
      }

      guard let data = try? Data(contentsOf: url) else {
        continue
      }

      guard let certificate = SecCertificateCreateWithData(nil, data as CFData) else {
        continue
      }

      guard let tkCertificate = TKTokenKeychainCertificate(certificate: certificate, objectID: fileName) else {
        continue
      }

      guard let tkPrivateKey = TKTokenKeychainKey(certificate: certificate, objectID: fileName) else {
        continue
      }

      tkPrivateKey.canDecrypt = true
      tkPrivateKey.canSign = true
      tkPrivateKey.canPerformKeyExchange = true
      tkPrivateKey.isSuitableForLogin = true

//      items.append(tkCertificate)
      items.append(tkPrivateKey)
    }

    os_log("getTokens append")

    keychainContents!.fill(with: items)
  }
}
