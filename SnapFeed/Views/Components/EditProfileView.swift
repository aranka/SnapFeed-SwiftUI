import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: EditProfileViewModel
    @EnvironmentObject var languageManager: LanguageManager
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    dismiss()
                } label: {
                    Text("common.cancel".localized)
                }
                
                Spacer()
                
                Text("navigation.edit.profile".localized)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button{
                    Task {
                        try await viewModel.updateUserData()
                        dismiss()
                    }
                } label: {
                    Text("common.done".localized)
                }
            }
            .padding(.horizontal)
            
            Divider()
            
            PhotosPicker(
                selection: $viewModel.selectedImage,
                matching: .images,
                preferredItemEncoding: .current
            ){
                VStack{ 
                    let profileImage = viewModel.profileImage ?? Image(systemName: "person")
                    profileImage
                        .resizable()
                        .foregroundStyle(.white)
                        .background(.gray)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                    
                    Text("profile.edit.picture".localized)
                        .font(.footnote)
                        .fontWeight(.bold)
                    
                    Divider()
                }
                
            }
            .padding(.vertical, 8)
            
            VStack{
                EditProfileRowView(title: "profile.name".localized, placeholder: "profile.name.placeholder".localized, text: $viewModel.fullname)
                EditProfileRowView(title: "profile.bio".localized, placeholder: "profile.bio.placeholder".localized, text: $viewModel.bio)
            }
            
            Spacer()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = PreviewHelpers.makeViewModelFactory()
        EditProfileView(viewModel: viewModelFactory.makeEditProfileViewModel(user: User.MOCK_USERS[0]))
    }
}
