import Foundation

/// Protocol for LoginViewModel
protocol LoginViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    
    func signIn() async throws
}

