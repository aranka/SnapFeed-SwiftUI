import Foundation
import SwiftUI

/// Coordinator for authentication flow
class AuthenticationCoordinator: ObservableObject, SwiftUICoordinator {
    
    // MARK: - SwiftUICoordinator
    typealias Route = AuthenticationRoute
    @Published var path = NavigationPath()
    
    // MARK: - Dependencies
    private let container: DependencyContainer
    
    // MARK: - Initialization
    init(container: DependencyContainer = .shared) {
        self.container = container
    }
    
    // MARK: - Navigation
    func navigate(to route: AuthenticationRoute) {
        path.append(route)
    }
    
    func showLogin() {
        navigate(to: .login)
    }
    
    func showAddEmail() {
        navigate(to: .addEmail)
    }
    
    func showCreateUsername() {
        navigate(to: .createUsername)
    }
    
    func showCreatePassword() {
        navigate(to: .createPassword)
    }
    
    func showCompleteSignUp() {
        navigate(to: .completeSignUp)
    }
}

// MARK: - AuthenticationRoute
enum AuthenticationRoute: Hashable {
    case login
    case addEmail
    case createUsername
    case createPassword
    case completeSignUp
}

