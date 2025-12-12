import Foundation
import SwiftUI
import PhotosUI
import FirebaseFirestore

@MainActor
class EditProfileViewModel: EditProfileViewModelProtocol {
    
    @Published var user: User
    @Published var fullname: String = ""
    @Published var bio: String = ""
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(from: selectedImage)
            }
        }
    }
    @Published var profileImage: Image? = nil
    private var uiImage: UIImage?
    
    init(user: User) {
        self.user = user   
    }
    
    func loadImage(from item: PhotosPickerItem?) async {
        guard let item = item,
              let data = try? await item.loadTransferable(type: Data.self),
              let uiImage = UIImage(data: data)
        else { return }
        
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        var data: [String: Any] = [:]
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        if !fullname.isEmpty && fullname != user.fullname {
            data["fullname"] = fullname
        }
        
        if !bio.isEmpty && bio != user.bio {
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection(FirestoreConstants.Collections.users).document(user.id).updateData(data)
        }
    }
    
}
