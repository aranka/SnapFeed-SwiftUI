import Foundation
import SwiftUI

/// Factory for creating ViewModels with dependency injection
class ViewModelFactory {
    
    // MARK: - Dependencies
    private let container: DependencyContainer
    
    // MARK: - Initialization
    init(container: DependencyContainer = .shared) {
        self.container = container
    }
    
    // MARK: - ViewModel Creation Methods
    
    /// Create ContentViewModel
    func makeContentViewModel() -> ContentViewModel {
        let authService: any AuthServiceProtocol = container.resolve((any AuthServiceProtocol).self)
        return ContentViewModel(authService: authService)
    }
    
    /// Create LoginViewModel
    func makeLoginViewModel() -> LoginViewModel {
        let authService: any AuthServiceProtocol = container.resolve((any AuthServiceProtocol).self)
        return LoginViewModel(authService: authService)
    }
    
    /// Create RegisterViewModel
    func makeRegisterViewModel() -> RegisterViewModel {
        let authService: any AuthServiceProtocol = container.resolve((any AuthServiceProtocol).self)
        return RegisterViewModel(authService: authService)
    }
    
    /// Create SearchViewModel
    func makeSearchViewModel() -> SearchViewModel {
        let userService = container.resolve(UserServiceProtocol.self)
        return SearchViewModel(userService: userService)
    }
    
    /// Create EditProfileViewModel
    @MainActor func makeEditProfileViewModel(user: User) -> EditProfileViewModel {
        return EditProfileViewModel(user: user)
    }
    
    /// Create UploadPostViewModel
    func makeUploadPostViewModel() -> UploadPostViewModel {
        return UploadPostViewModel()
    }
}

