import SwiftUI

struct CreatePasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var registerViewModel: RegisterViewModel
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                
                Text("register.add.password.title".localized)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color("buttonTextColor"))
                
                SecureFieldWithButton("register.add.password.placeholder".localized, text: $registerViewModel.password)
                    .autocapitalization(.none)
                
                NavigationLink{
                    CompleteSignUpView(registerViewModel: registerViewModel)
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

struct CreatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = PreviewHelpers.makeViewModelFactory()
        CreatePasswordView(registerViewModel: viewModelFactory.makeRegisterViewModel())
    }
}
