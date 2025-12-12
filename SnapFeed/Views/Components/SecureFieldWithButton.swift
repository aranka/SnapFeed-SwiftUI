import SwiftUI

struct SecureFieldWithButton: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing){
            Group{
                if isSecured {
                    SecureField(title, text: $text)
                        .modifier(SFTextFieldModifier())
                } else {
                    TextField(title, text: $text)
                        .modifier(SFTextFieldModifier())
                }
            }
            Button{
                isSecured.toggle()
            } label: {
                
                Image(systemName: isSecured ? "eye.slash" : "eye")
                    .foregroundColor(Color("buttonTextColor"))
            }
            .padding(.horizontal, 36)
        }
    }
}

struct SecureFieldWithButton_Previews: PreviewProvider {
    static var previews: some View {
        SecureFieldWithButton("Title", text: .constant(""))
    }
}
