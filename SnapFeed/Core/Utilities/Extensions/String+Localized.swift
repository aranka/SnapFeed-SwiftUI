import Foundation

extension String {
    /// Returns localized string using LanguageManager
    var localized: String {
        return LanguageManager.shared.getLocalizedString(self)
    }
    
    /// Returns localized string with format arguments
    func localized(with arguments: CVarArg...) -> String {
        let format = LanguageManager.shared.getLocalizedString(self)
        return String(format: format, arguments: arguments)
    }
}

