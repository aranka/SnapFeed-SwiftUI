import SwiftUI
import PhotosUI

struct UploadPostView: View {
    
    @ObservedObject var viewModel: UploadPostViewModel
    @State private var caption: String = ""
    @State private var imagePickerPresented: Bool = false
    @Binding var tabIndex: Int
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    caption = ""
                    viewModel.selectedImage = nil
                    viewModel.postImage = nil
                    tabIndex = 0
                } label: {
                    Text("upload.cancel".localized)
                }
                
                Spacer()
                
                Text("navigation.new.post".localized)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button{} label: {
                    Text("upload.upload".localized)
                }
                
            }
            .padding(.horizontal)
            
            HStack{
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                    
                }
                TextField(
                    "upload.caption.placeholder".localized, 
                    text: $caption,
                    axis: .vertical
                )
                
            }
            
            Spacer()
        }
        .onAppear(){
            imagePickerPresented.toggle()
        }
        .photosPicker(
            isPresented: $imagePickerPresented, 
            selection: $viewModel.selectedImage,
            matching: .images,
            preferredItemEncoding: .current
        )
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = PreviewHelpers.makeViewModelFactory()
        UploadPostView(
            viewModel: viewModelFactory.makeUploadPostViewModel(), 
            tabIndex: .constant(0)
        )
    }
}
