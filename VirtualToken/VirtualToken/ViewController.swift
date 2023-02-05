import Cocoa
import CryptoTokenKit
import OSLog

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    os_log("viewDidLoad")
//    testLoadCertificates()
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  func testLoadCertificates() {
    let fileNames = ["john", "jane"]
    for fileName in fileNames {
      guard let url = Bundle.main.url(forResource: fileName, withExtension: "crt") else {
        continue
      }

      print(url)

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

      print(tkPrivateKey)
      print(tkCertificate)
    }
  }
}

