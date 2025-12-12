import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class AuthService: AuthServiceProtocol {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    // MARK: - AuthServiceProtocol Publishers
    var userSessionPublisher: AnyPublisher<FirebaseAuth.User?, Never> {
        $userSession.eraseToAnyPublisher()
    }
    
    var currentUserPublisher: AnyPublisher<User?, Never> {
        $currentUser.eraseToAnyPublisher()
    }
    
    
    
    init() {
        Task {
            try await loadUserData()
        }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
           let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print(error.localizedDescription)  
        }   
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            await self.uploadUserData(
                uid: result.user.uid,
                username: username,
                email: email
            )
            try await loadUserData()
        } catch {
            print(error.localizedDescription)  
        }
    }
    
    func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection(FirestoreConstants.Collections.users).document(user.id).setData(encodedUser)
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection(FirestoreConstants.Collections.users).document(currentUID).getDocument()
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
}
