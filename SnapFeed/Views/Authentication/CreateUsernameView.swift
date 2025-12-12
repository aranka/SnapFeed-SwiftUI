import SwiftUI

struct CreateUsernameView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var registerViewModel: RegisterViewModel
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                
                Text("register.add.username.title".localized)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color("buttonTextColor"))
                
                TextField("register.add.username.placeholder".localized, text: $registerViewModel.username)
                    .autocapitalization(.none)
                    .modifier(SFTextFieldModifier())
                
                NavigationLink{
                    CreatePasswordView(registerViewModel: registerViewModel)
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("common.next".localized)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("buttonTextColor"))
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color("buttonTextColor"))
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("buttonTextColor"), lineWidth: 1)
                )
                .padding(.horizontal, 24)
                .padding(.top)
                
                Spacer()
            }.toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
}

struct CreateUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = PreviewHelpers.makeViewModelFactory()
        CreateUsernameView(registerViewModel: viewModelFactory.makeRegisterViewModel())
    }
}
