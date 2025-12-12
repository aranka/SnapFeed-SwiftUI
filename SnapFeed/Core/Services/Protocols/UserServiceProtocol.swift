import Foundation

/// Protocol for user service
protocol UserServiceProtocol {
    @MainActor
    func fetchAllUsers() async throws -> [User]
}

