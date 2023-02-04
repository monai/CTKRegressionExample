# CTKRegressionExample

This project demonstrates the `CryptoTokenKit` framework regression introduced in macOS Ventura and is still present in version 13.2.

`CryptoTokenKit` tokens expose their items as standard keychain items (see [documentation](https://developer.apple.com/documentation/cryptotokenkit/using_cryptographic_assets_stored_on_a_smart_card)). Starting macOS Ventura, they no longer do so. `SecItemCopyMatching` with passed `kSecAttrTokenID: tokenID` returns `errSecItemNotFound` status. Even though `TKTokenWatcher` reports the token itself is present in the system, it's impossible to retrieve any item from it on macOS Ventura.

## Tested environments

| macOS version   | Platform      | Status       |
| --------------- | ------------- | ------------ |
| Monterey 12.6.3 | Intel         | works        |
| Ventura 13.2    | Intel         | doesn't work |
| Ventura 13.2    | Apple Silicon | doesn't work |

## Tested card

MaskTech: https://www.nsc.vrm.lt/files/Toolbox-osx_LT.zip
