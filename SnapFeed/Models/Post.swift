import Foundation

struct Post: Identifiable, Codable, Hashable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Date
    var user: User?
}

extension Post {
    static var MOCK_POST: [Post] = [
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            likes: 11,
            imageUrl: "sample-image-1",
            timestamp: Date(),
            user: User.MOCK_USERS[0]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            likes: 12,
            imageUrl: "sample-image-2",
            timestamp: Date(),
            user: User.MOCK_USERS[0]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            likes: 13,
            imageUrl: "sample-image-3",
            timestamp: Date(),
            user: User.MOCK_USERS[0]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            likes: 14,
            imageUrl: "sample-image-4",
            timestamp: Date(),
            user: User.MOCK_USERS[0]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            likes: 15,
            imageUrl: "sample-image-5",
            timestamp: Date(),
            user: User.MOCK_USERS[0]
        )
    ]
}
