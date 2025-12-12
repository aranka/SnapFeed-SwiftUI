import Foundation
import SwiftUI
import PhotosUI

/// Protocol for EditProfileViewModel
@MainActor
protocol EditProfileViewModelProtocol: ObservableObject {
    var user: User { get set }
    var fullname: String { get set }
    var bio: String { get set }
    var selectedImage: PhotosPickerItem? { get set }
    var profileImage: Image? { get }
    
    func loadImage(from item: PhotosPickerItem?) async
    func updateUserData() async throws
}

