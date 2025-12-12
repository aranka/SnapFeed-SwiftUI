import Foundation

class RegisterViewModel: RegisterViewModelProtocol {

    @Published var username:String = "" 
    @Published var email:String = "" 
    @Published var password:String = "" 
    @Published var errorMessage:String = ""
    
    // MARK: - Dependencies
    private let authService: any AuthServiceProtocol
    
    // MARK: - Initialization
    init(authService: any AuthServiceProtocol) {
        self.authService = authService
    }
    
    @MainActor
    func createUser() async throws {
        guard validate() else { return }
        
        try await authService.createUser(email: email, password: password, username: username)
        username = ""
        email = ""
        password = ""
        errorMessage = ""
    }
    
    func validate() -> Bool {
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "error.email.required".localized
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "error.email.invalid".localized
            return false
        }
        
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "error.username.required".localized
            return false
        }
        
        guard !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "error.password.required".localized
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "error.password.length".localized
            return false
        }
        
        return true
    }
}
