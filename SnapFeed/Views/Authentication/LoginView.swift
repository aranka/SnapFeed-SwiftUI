import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @ObservedObject var registerViewModel: RegisterViewModel
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 40)
                VStack(spacing: 10){
                    TextField("login.email.placeholder".localized, text: $viewModel.email)
                        .modifier(SFTextFieldModifier())
                    SecureFieldWithButton("login.password.placeholder".localized, text: $viewModel.password)
                        .autocapitalization(.none)
                }
                Button{
                    Task {
                        try await viewModel.signIn()
                    }
                } label: {
                    Text("login.button".localized)
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
                }
                
                Button{
                    
                } label: {
                    Text("login.forget.password".localized)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(height: 40)
                        .padding(.horizontal, 24)
                        .padding(.top)
                }
                
                HStack{
                    Rectangle()
                        .frame(height: 0.5)
                    Text("login.or".localized)
                    Rectangle()
                        .frame(height: 0.5)
                }
                .foregroundStyle(Color(.lightGray))
                .padding(.horizontal, 24)
                
                HStack{
                    Image("facebook")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("login.facebook.continue".localized)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                }
                .padding(.top)
                
                Spacer()
                Divider()
                
                NavigationLink{
                    AddEmailView(registerViewModel: registerViewModel)
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack{
                        Text("login.sign.up".localized)
                        Text("login.sign.up.button".localized)
                            .fontWeight(.semibold)
                    }
                }.padding(.top)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = PreviewHelpers.makeViewModelFactory()
        LoginView(
            viewModel: viewModelFactory.makeLoginViewModel(),
            registerViewModel: viewModelFactory.makeRegisterViewModel()
        )
    }
}
