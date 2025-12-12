import Foundation
import SwiftUI

/// Helper for creating dependencies in Previews
/// Uses DependencyContainer.shared for convenience in previews
enum PreviewHelpers {
    
    /// Creates a DependencyContainer configured with default services
    static func makeContainer() -> DependencyContainer {
        let container = DependencyContainer()
        container.registerDefaultServices()
        return container
    }
    
    /// Creates a ViewModelFactory with default container
    static func makeViewModelFactory() -> ViewModelFactory {
        return ViewModelFactory(container: makeContainer())
    }
    
    /// Creates a ViewFactory with default container
    static func makeViewFactory() -> ViewFactory {
        return ViewFactory(container: makeContainer())
    }
}

