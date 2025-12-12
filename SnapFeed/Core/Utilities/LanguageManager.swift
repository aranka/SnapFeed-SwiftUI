import Foundation
import SwiftUI

/// Supported languages in the app
enum AppLanguage: String, CaseIterable {
    case turkish = "tr"
    case english = "en"
    
    var displayName: String {
        switch self {
        case .turkish: return "Türkçe"
        case .english: return "English"
        }
    }
}

/// Protocol for language management
protocol LanguageManagerProtocol: ObservableObject {
    var currentLanguage: AppLanguage { get }
    func setLanguage(_ language: AppLanguage)
    func getLocalizedString(_ key: String) -> String
}

/// Service for managing app language and localization
class LanguageManager: LanguageManagerProtocol {
    
    // MARK: - Singleton
    static let shared = LanguageManager()
    
    // MARK: - Published Properties
    @Published var currentLanguage: AppLanguage
    
    // MARK: - Constants
    private let languageKey = "AppLanguage"
    
    // MARK: - Initialization
    init() {
        // Get saved language or detect from device
        if let savedLanguageCode = UserDefaults.standard.string(forKey: languageKey),
           let savedLanguage = AppLanguage(rawValue: savedLanguageCode) {
            self.currentLanguage = savedLanguage
        } else {
            // Detect device language
            let deviceLanguage = Locale.current.languageCode ?? "en"
            // If device language is Turkish, use Turkish, otherwise use English
            self.currentLanguage = deviceLanguage == "tr" ? .turkish : .english
            // Save the detected language
            UserDefaults.standard.set(self.currentLanguage.rawValue, forKey: languageKey)
        }
        
        // Apply language to bundle
        applyLanguage()
    }
    
    // MARK: - Language Management
    func setLanguage(_ language: AppLanguage) {
        currentLanguage = language
        UserDefaults.standard.set(language.rawValue, forKey: languageKey)
        applyLanguage()
        
        // Post notification for language change
        NotificationCenter.default.post(name: .languageChanged, object: nil)
    }
    
    // MARK: - Localization
    func getLocalizedString(_ key: String) -> String {
        // Try to get localized string from specific language bundle
        if let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
            // If key not found, return the key itself
            if localizedString != key {
                return localizedString
            }
        }
        // Fallback to main bundle
        let localizedString = NSLocalizedString(key, comment: "")
        return localizedString.isEmpty ? key : localizedString
    }
    
    // MARK: - Private Methods
    private func applyLanguage() {
        // Set language for current bundle
        UserDefaults.standard.set([currentLanguage.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}

// MARK: - Notification Name
extension Notification.Name {
    static let languageChanged = Notification.Name("languageChanged")
}

