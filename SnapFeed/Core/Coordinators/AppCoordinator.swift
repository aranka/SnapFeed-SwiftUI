import Foundation
import SwiftUI
import Combine
import FirebaseAuth

/// Main application coordinator that manages the overall navigation flow
class AppCoordinator: ObservableObject {
    
    // MARK: - Properties
    @Published var currentView: AppView = .authentication
    
    // MARK: - Child Coordinators
    var authenticationCoordinator: AuthenticationCoordinator?
    var mainCoordinator: MainCoordinator?
    
    // MARK: - Dependencies
    private let container: DependencyContainer
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(container: DependencyContainer = .shared) {
        self.container = container
        setupAuthObserver()
    }
    
    // MARK: - Setup
    private func setupAuthObserver() {
        let authService: any AuthServiceProtocol = container.resolve((any AuthServiceProtocol).self)
        
        authService.userSessionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (userSession: FirebaseAuth.User?) in
                if userSession == nil {
                    self?.showAuthentication()
                } else {
                    self?.showMain()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Navigation
    func showAuthentication() {
        currentView = .authentication
        authenticationCoordinator = AuthenticationCoordinator(container: container)
        mainCoordinator = nil
    }
    
    func showMain() {
        currentView = .main
        mainCoordinator = MainCoordinator(container: container)
        authenticationCoordinator = nil
    }
}

// MARK: - AppView
enum AppView {
    case authentication
    case main
}

