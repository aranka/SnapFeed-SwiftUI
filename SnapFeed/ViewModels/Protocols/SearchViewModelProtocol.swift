import Foundation

/// Protocol for SearchViewModel
protocol SearchViewModelProtocol: ObservableObject {
    var users: [User] { get }
    
    @MainActor
    func fetchAllUsers() async throws
}

