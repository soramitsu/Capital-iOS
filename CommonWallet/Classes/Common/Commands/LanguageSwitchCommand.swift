import Foundation

final class LanguageSwitchCommand: WalletCommandProtocol {
    let resolver: ResolverProtocol
    let language: WalletLanguage

    init(resolver: ResolverProtocol, language: WalletLanguage) {
        self.resolver = resolver
        self.language = language
    }

    func execute() throws {
        L10n.sharedLanguage = language
        resolver.localizationManager?.selectedLocalization = language.rawValue
    }
}
