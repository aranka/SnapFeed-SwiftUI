import Foundation
import FirebaseAuth

struct User: Identifiable, Codable, Hashable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(
            id: UUID().uuidString, 
            username: "monkey1", 
            profileImageUrl: "avatar", 
            fullname: "Monkey 1", 
            bio: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", 
            email: "monkey1@gmail.com"
        ),
        .init(
            id: UUID().uuidString, 
            username: "monkey2", 
            profileImageUrl: "avatar", 
            fullname: "Monkey 2", 
            bio: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", 
            email: "monkey2@gmail.com"
        ),
        .init(
            id: UUID().uuidString, 
            username: "monkey3", 
            profileImageUrl: "avatar", 
            fullname: "Monkey 3", 
            bio: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", 
            email: "monkey3@gmail.com"
        ),
        .init(
            id: UUID().uuidString, 
            username: "monkey4", 
            profileImageUrl: "avatar", 
            fullname: "Monkey 4", 
            bio: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", 
            email: "monkey4@gmail.com"
        )
        ,.init(
            id: UUID().uuidString, 
            username: "monkey5", 
            profileImageUrl: "avatar", 
            fullname: "Monkey 5", 
            bio: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", 
            email: "monkey5@gmail.com"
        )
    ]
}
