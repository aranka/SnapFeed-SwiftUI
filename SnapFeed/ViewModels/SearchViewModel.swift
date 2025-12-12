import Foundation

class SearchViewModel: SearchViewModelProtocol {

    @Published var users: [User] = []
    
    // MARK: - Dependencies
    private let userService: any UserServiceProtocol
    
    // MARK: - Initialization
    init(userService: any UserServiceProtocol) {
        self.userService = userService
        Task {
            try await fetchAllUsers()
        }
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await userService.fetchAllUsers()
    }
}
