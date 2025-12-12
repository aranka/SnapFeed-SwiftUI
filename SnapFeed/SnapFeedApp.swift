import SwiftUI

@main
struct SnapFeedApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // MARK: - Composition Root
    // This is where all dependencies are configured and wired together
    // Following DI principles: dependencies are created here and injected down
    private let container: DependencyContainer
    private let viewFactory: ViewFactory
    
    init() {
        // Initialize language manager (detects device language and sets app language)
        _ = LanguageManager.shared
        
        // Create container at composition root
        let container = DependencyContainer()
        container.registerDefaultServices()
        
        // Create factories with injected dependencies
        let viewFactory = ViewFactory(container: container)
        
        // Store dependencies
        self.container = container
        self.viewFactory = viewFactory
    }
    
    var body: some Scene {
        WindowGroup {
            viewFactory.makeContentView()
                .environmentObject(LanguageManager.shared)
        }
    }
}
