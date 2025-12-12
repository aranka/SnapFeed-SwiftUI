import Foundation
import SwiftUI
import FirebaseStorage

struct ImageUploader {
    
    static func uploadImage(image: UIImage) async throws -> String? {
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return nil }
        
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "\(FirestoreConstants.StoragePaths.profileImages)\(filename)")
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
