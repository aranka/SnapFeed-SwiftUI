import Foundation

/// Dependency Container for managing and resolving dependencies
/// Follows Dependency Injection principles: services are registered and resolved through the container
class DependencyContainer {
    
    // MARK: - Singleton (for convenience, but not required)
    static let shared: DependencyContainer = {
        let container = DependencyContainer()
        container.registerDefaultServices()
        return container
    }()
    
    // MARK: - Private Storage
    private var services: [String: Any] = [:]
    private var factories: [String: () -> Any] = [:]
    
    // MARK: - Initialization
    init() {
        // Note: Default services are not registered automatically
        // They should be registered explicitly via registerDefaultServices() or in composition root
    }
    
    // MARK: - Registration
    /// Register a service instance (singleton)
    func register<T>(_ type: T.Type, instance: T) {
        let key = String(describing: type)
        services[key] = instance
    }
    
    /// Register a factory closure for creating instances
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        factories[key] = factory
    }
    
    // MARK: - Resolution
    /// Resolve a dependency
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        
        // First try to get from services (singleton)
        if let service = services[key] as? T {
            return service
        }
        
        // Then try to create from factory
        if let factory = factories[key] as? () -> T {
            return factory()
        }
        
        // If not found, try to create a new instance (for protocol types)
        fatalError("Dependency \(key) not registered")
    }
    
    // MARK: - Default Services Registration
    func registerDefaultServices() {
        // Register AuthServiceProtocol as singleton (one instance per container)
        let authService: any AuthServiceProtocol = AuthService()
        register((any AuthServiceProtocol).self, instance: authService)
        
        // Register UserServiceProtocol as singleton (one instance per container)
        let userService: any UserServiceProtocol = UserService()
        register(UserServiceProtocol.self, instance: userService)
    }
}

