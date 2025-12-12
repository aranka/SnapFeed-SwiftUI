import Foundation

/// Protocol for RegisterViewModel
protocol RegisterViewModelProtocol: ObservableObject {
    var username: String { get set }
    var email: String { get set }
    var password: String { get set }
    var errorMessage: String { get set }
    
    @MainActor
    func createUser() async throws
    
    func validate() -> Bool
}

