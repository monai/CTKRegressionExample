import CryptoTokenKit
import OSLog

class TokenDriver: TKSmartCardTokenDriver, TKSmartCardTokenDriverDelegate {
  override init() {
    super.init()

    os_log("TokenDriver init")
  }

  func tokenDriver(_ driver: TKSmartCardTokenDriver, createTokenFor smartCard: TKSmartCard, aid AID: Data?) throws -> TKSmartCardToken {
    os_log("TokenDriver tokenDriver: %{public}@ createTokenFor: %{public}@ aid: %{public}@", driver, smartCard, AID?.hexDescription ?? "<Undefined AID>")

    let token: Token
    do {
      token = try Token(smartCard: smartCard, aid: AID, tokenDriver: self)
    } catch {
      os_log("TokenDriver tokenDriver: error: %{public}@", error.localizedDescription)

      throw error
    }

    os_log("TokenDriver tokenDriver: success: %{public}@", token)

    return token
  }

}
