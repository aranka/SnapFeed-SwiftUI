import SwiftUI

struct AddEmailView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var registerViewModel: RegisterViewModel
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                
                Text("register.add.email.title".localized)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color("buttonTextColor"))
                
                Text("register.add.email.description".localized)
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                
                TextField("register.add.email.placeholder".localized, text: $registerViewModel.email)
                    .autocapitalization(.none)
                    .modifier(SFTextFieldModifier())
                
                NavigationLink{
                    CreateUsernameView(registerViewModel: registerViewModel)
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

struct AddEmailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = PreviewHelpers.makeViewModelFactory()
        AddEmailView(registerViewModel: viewModelFactory.makeRegisterViewModel())
    }
}
