import Foundation
import SwiftUI
import PhotosUI

class UploadPostViewModel: UploadPostViewModelProtocol {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet{
            Task {
                await loadImage(from: selectedImage)
            }
        }
    }
    
    @Published var postImage: Image?
    
    @MainActor
    func loadImage(from item: PhotosPickerItem?) async {
        guard let item = item,
              let data = try? await item.loadTransferable(type: Data.self),
              let uiImage = UIImage(data: data)
        else { return }
        
        self.postImage = Image(uiImage: uiImage)
    }
    
}
