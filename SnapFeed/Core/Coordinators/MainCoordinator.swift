import Foundation
import SwiftUI

/// Coordinator for main app flow (after authentication)
class MainCoordinator: ObservableObject, SwiftUICoordinator {
    
    // MARK: - SwiftUICoordinator
    typealias Route = MainRoute
    @Published var path = NavigationPath()
    
    // MARK: - Dependencies
    private let container: DependencyContainer
    
    // MARK: - Initialization
    init(container: DependencyContainer = .shared) {
        self.container = container
    }
    
    // MARK: - Navigation
    func navigate(to route: MainRoute) {
        path.append(route)
    }
    
    func showProfile(user: User) {
        navigate(to: .profile(user))
    }
    
    func showEditProfile() {
        navigate(to: .editProfile)
    }
    
    func showSearch() {
        navigate(to: .search)
    }
    
    func showUploadPost() {
        navigate(to: .uploadPost)
    }
}

// MARK: - MainRoute
enum MainRoute: Hashable {
    case profile(User)
    case editProfile
    case search
    case uploadPost
}

