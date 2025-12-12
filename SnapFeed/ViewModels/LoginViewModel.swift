import Foundation

class LoginViewModel: LoginViewModelProtocol {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: - Dependencies
    private let authService: any AuthServiceProtocol
    
    // MARK: - Initialization
    init(authService: any AuthServiceProtocol) {
        self.authService = authService
    }
    
    func signIn() async throws {
        do {
            try await authService.login(withEmail: email, password: password)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
