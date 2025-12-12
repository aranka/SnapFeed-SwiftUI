import Foundation
import SwiftUI
import PhotosUI

/// Protocol for UploadPostViewModel
protocol UploadPostViewModelProtocol: ObservableObject {
    var selectedImage: PhotosPickerItem? { get set }
    var postImage: Image? { get }
    
    @MainActor
    func loadImage(from item: PhotosPickerItem?) async
}

