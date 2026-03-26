import Foundation
import Observation
import WinUI
import RsHelper

@Observable
public class AppContext {
    public let productName: String
    public let supportDirectory: URL
    public let preferences: Preferences
    public var theme: AppTheme {
        didSet {
            guard oldValue != theme else { return }
            Application.current.requestedTheme = theme.applicationTheme
            preferences.save(theme)
        }
    }
    public var language: AppLanguage {
        didSet {
            guard oldValue != language else { return }
            preferences.save(language)
        }
    }
    public let bundle: Bundle
    
    var modules: [any Module] = []

    private init(_ group: String, _ product: String, _ bundle: Bundle, _ loadAppearence: Bool = false) {
        productName = product
        supportDirectory = URL.applicationSupportDirectory.reachingChild(named: "\(group)/\(product)/")!       
        preferences = JsonPreferences.makeAppStandard(group: group, product: product)
        self.theme = loadAppearence ?  preferences.load(for: AppTheme.self) : .auto 
        self.language = loadAppearence ? preferences.load(for: AppLanguage.self) : .en_US
        self.bundle = bundle
    }

    static func gui(_ group: String, _ product: String, _ bundle: Bundle) -> AppContext {
        let ctx = AppContext(group, product, bundle, true)

        if Application.current.requestedTheme != ctx.theme.applicationTheme {
            Application.current.requestedTheme = ctx.theme.applicationTheme
        }

        return ctx
    }

    static func cli() -> AppContext {
        return AppContext("SwiftWorks", "RsUI", .main)
    }

    public func tr(_ keyAndValue: String, _ table: String? = nil) -> String {
        return String(localized: keyAndValue, table: table, bundle: bundle, locale: language.locale)
    }
}