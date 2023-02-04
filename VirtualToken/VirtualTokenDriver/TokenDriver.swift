import CryptoTokenKit
import OSLog

class TokenDriver: TKSmartCardTokenDriver, TKSmartCardTokenDriverDelegate {

  func tokenDriver(_ driver: TKSmartCardTokenDriver, createTokenFor smartCard: TKSmartCard, aid AID: Data?) throws -> TKSmartCardToken {
    os_log("TokenDriver tokenDriver: %{public}@ createTokenFor: %{public}@ aid: %{public}@", driver, smartCard, AID?.hexDescription ?? "<AID>")

    return try Token(smartCard: smartCard, aid: AID, tokenDriver: self)
  }

}
