import Foundation
import SwiftUI

/// Factory for creating Views with dependency injection
class ViewFactory {
    
    // MARK: - Dependencies
    private let container: DependencyContainer
    private let viewModelFactory: ViewModelFactory
    
    // MARK: - Initialization
    init(container: DependencyContainer = .shared) {
        self.container = container
        self.viewModelFactory = ViewModelFactory(container: container)
    }
    
    // MARK: - View Creation Methods
    
    /// Create ContentView
    func makeContentView() -> ContentView {
        let viewModel = viewModelFactory.makeContentViewModel()
        let registerViewModel = viewModelFactory.makeRegisterViewModel()
        return ContentView(
            viewModel: viewModel,
            registerViewModel: registerViewModel,
            viewFactory: self
        )
    }
    
    /// Create LoginView
    func makeLoginView(registerViewModel: RegisterViewModel? = nil) -> LoginView {
        let viewModel = viewModelFactory.makeLoginViewModel()
        let registerVM = registerViewModel ?? viewModelFactory.makeRegisterViewModel()
        return LoginView(viewModel: viewModel, registerViewModel: registerVM)
    }
    
    /// Create AddEmailView
    func makeAddEmailView() -> AddEmailView {
        let registerViewModel = viewModelFactory.makeRegisterViewModel()
        return AddEmailView(registerViewModel: registerViewModel)
    }
    
    /// Create CreateUsernameView
    func makeCreateUsernameView() -> CreateUsernameView {
        let registerViewModel = viewModelFactory.makeRegisterViewModel()
        return CreateUsernameView(registerViewModel: registerViewModel)
    }
    
    /// Create CreatePasswordView
    func makeCreatePasswordView() -> CreatePasswordView {
        let registerViewModel = viewModelFactory.makeRegisterViewModel()
        return CreatePasswordView(registerViewModel: registerViewModel)
    }
    
    /// Create CompleteSignUpView
    func makeCompleteSignUpView() -> CompleteSignUpView {
        let registerViewModel = viewModelFactory.makeRegisterViewModel()
        return CompleteSignUpView(registerViewModel: registerViewModel)
    }
    
    /// Create MainTabView
    func makeMainTabView(user: User) -> MainTabView {
        return MainTabView(user: user, viewFactory: self)
    }
    
    /// Create FeedView
    func makeFeedView() -> FeedView {
        return FeedView()
    }
    
    /// Create SearchView
    func makeSearchView() -> SearchView {
        let viewModel = viewModelFactory.makeSearchViewModel()
        return SearchView(viewModel: viewModel, viewFactory: self)
    }
    
    /// Create UploadPostView
    func makeUploadPostView(tabIndex: Binding<Int>) -> UploadPostView {
        let viewModel = viewModelFactory.makeUploadPostViewModel()
        return UploadPostView(viewModel: viewModel, tabIndex: tabIndex)
    }
    
    /// Create ProfileView
    func makeProfileView(user: User) -> ProfileView {
        return ProfileView(user: user, viewFactory: self)
    }
    
    /// Create MyProfileView
    func makeMyProfileView(user: User) -> MyProfileView {
        let authService: any AuthServiceProtocol = container.resolve((any AuthServiceProtocol).self)
        return MyProfileView(user: user, authService: authService, viewFactory: self)
    }
    
    /// Create EditProfileView
    @MainActor func makeEditProfileView(user: User) -> EditProfileView {
        let viewModel = viewModelFactory.makeEditProfileViewModel(user: user)
        return EditProfileView(viewModel: viewModel)
    }
}

