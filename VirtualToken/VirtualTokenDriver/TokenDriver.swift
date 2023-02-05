import CryptoTokenKit
import OSLog

class TokenDriver: TKSmartCardTokenDriver, TKSmartCardTokenDriverDelegate {

  func tokenDriver(_ driver: TKSmartCardTokenDriver, createTokenFor smartCard: TKSmartCard, aid AID: Data?) throws -> TKSmartCardToken {
    os_log("TokenDriver tokenDriver: %{public}@ createTokenFor: %{public}@ aid: %{public}@", driver, smartCard, AID?.hexDescription ?? "<AID>")

    let token: Token
    do {
      token = try Token(smartCard: smartCard, aid: AID, tokenDriver: self)
    } catch {
      os_log("%{public}@", error.localizedDescription)

      throw error
    }

    return token
  }

}
