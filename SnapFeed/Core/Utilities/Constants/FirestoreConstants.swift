import Foundation

/// Constants for Firestore collection names
enum FirestoreConstants {
    
    // MARK: - Collections
    enum Collections {
        static let users = "users"
        static let posts = "posts"
    }
    
    // MARK: - Storage Paths
    enum StoragePaths {
        static let profileImages = "/profile_image/"
        static let postImages = "/post_images/"
    }
}

