import CryptoTokenKit
import OSLog

class TokenSession: TKSmartCardTokenSession, TKTokenSessionDelegate {

  override init(token: TKToken) {
    super.init(token: token)

    self.delegate = self

    os_log("TokenSession init")
  }

//  override init() {
//    Self.log.debug("will init")
//    super.init()
//    // How is `delegate` set up, I hear you ask?  Our super class’s
//    // initialiser notices that `self` implements `TKTokenDriverDelegate`
//    // and, in that case, sets `delegate` to `self`.  Convenient but cryptic
//    // (r. 90838636).
//    log.debug("did init")
//  }

  func tokenSession(_ session: TKTokenSession, beginAuthFor operation: TKTokenOperation, constraint: Any) throws -> TKTokenAuthOperation {
    // Insert code here to create an instance of TKTokenAuthOperation based on the specified operation and constraint.
    // Note that the constraint was previously established when populating keychainContents during token initialization.

    os_log("TokenSession beginAuthFor constraint")

    return TKTokenSmartCardPINAuthOperation()
  }

  func tokenSession(_ session: TKTokenSession, supports operation: TKTokenOperation, keyObjectID: Any, algorithm: TKTokenKeyAlgorithm) -> Bool {
    // Indicate whether the given key supports the specified operation and algorithm.

    os_log("TokenSession supports keyObjectID algorithm")

    return true
  }

  func tokenSession(_ session: TKTokenSession, sign dataToSign: Data, keyObjectID: Any, algorithm: TKTokenKeyAlgorithm) throws -> Data {
    var signature: Data?

    os_log("TokenSession sign keyObjectID algorithm")

    // Insert code here to sign data using the specified key and algorithm.
    signature = nil

    if let signature = signature {
      return signature
    } else {
      // If the operation failed for some reason, fill in an appropriate error like objectNotFound, corruptedData, etc.
      // Note that responding with TKErrorCodeAuthenticationNeeded will trigger user authentication after which the current operation will be re-attempted.
      throw NSError(domain: TKErrorDomain, code: TKError.Code.authenticationNeeded.rawValue, userInfo: nil)
    }
  }

  func tokenSession(_ session: TKTokenSession, decrypt ciphertext: Data, keyObjectID: Any, algorithm: TKTokenKeyAlgorithm) throws -> Data {
    var plaintext: Data?

    os_log("TokenSession decrypt keyObjectID algorithm")

    // Insert code here to decrypt the ciphertext using the specified key and algorithm.
    plaintext = nil

    if let plaintext = plaintext {
      return plaintext
    } else {
      // If the operation failed for some reason, fill in an appropriate error like objectNotFound, corruptedData, etc.
      // Note that responding with TKErrorCodeAuthenticationNeeded will trigger user authentication after which the current operation will be re-attempted.
      throw NSError(domain: TKErrorDomain, code: TKError.Code.authenticationNeeded.rawValue, userInfo: nil)
    }
  }

  func tokenSession(_ session: TKTokenSession, performKeyExchange otherPartyPublicKeyData: Data, keyObjectID objectID: Any, algorithm: TKTokenKeyAlgorithm, parameters: TKTokenKeyExchangeParameters) throws -> Data {
    var secret: Data?

    os_log("TokenSession performKeyExchange keyObjectID algorithm parameters")

    // Insert code here to perform Diffie-Hellman style key exchange.
    secret = nil

    if let secret = secret {
      return secret
    } else {
      // If the operation failed for some reason, fill in an appropriate error like objectNotFound, corruptedData, etc.
      // Note that responding with TKErrorCodeAuthenticationNeeded will trigger user authentication after which the current operation will be re-attempted.
      throw NSError(domain: TKErrorDomain, code: TKError.Code.authenticationNeeded.rawValue, userInfo: nil)
    }
  }
}
