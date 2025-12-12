import Foundation
import FirebaseAuth
import Combine

/// Protocol for authentication service
protocol AuthServiceProtocol: ObservableObject {
    var userSession: FirebaseAuth.User? { get }
    var currentUser: User? { get }
    
    // Publishers for observing changes
    var userSessionPublisher: AnyPublisher<FirebaseAuth.User?, Never> { get }
    var currentUserPublisher: AnyPublisher<User?, Never> { get }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws
    
    func uploadUserData(uid: String, username: String, email: String) async
    
    @MainActor
    func loadUserData() async throws
    
    func signOut()
}

