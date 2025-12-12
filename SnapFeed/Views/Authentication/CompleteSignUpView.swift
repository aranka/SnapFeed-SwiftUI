import SwiftUI

struct CompleteSignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var registerViewModel: RegisterViewModel
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
      //  NavigationStack{
            VStack(spacing: 12){
                Spacer()
                
                Text("register.complete.title".localized(with: registerViewModel.username))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("buttonTextColor"))
                    .padding(.top)
                
                Text("register.complete.description".localized)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("buttonTextColor"))
                    .padding(.top)
                
                if !registerViewModel.errorMessage.isEmpty {
                    Text(registerViewModel.errorMessage)
                        .foregroundColor(.red)
                }
                
                Button{
                    Task {
                        do{
                            try await registerViewModel.createUser()
                        } catch{
                            print(error.localizedDescription)
                        }
                    }
                } label: {
                    Text("register.complete.button".localized)
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
            }
        }
    //}
}

struct CompleteSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = PreviewHelpers.makeViewModelFactory()
        CompleteSignUpView(registerViewModel: viewModelFactory.makeRegisterViewModel())
    }
}
