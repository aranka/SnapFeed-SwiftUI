import Foundation
import FirebaseFirestore

class UserService: UserServiceProtocol {
    
    @MainActor
    func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection(FirestoreConstants.Collections.users).getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
    
}
