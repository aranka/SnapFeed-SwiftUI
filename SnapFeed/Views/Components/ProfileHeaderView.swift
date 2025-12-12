import SwiftUI

struct ProfileHeaderView: View {
    
    let user: User
    @State private var showEditProfile: Bool = false
    
    // MARK: - Dependencies (injected)
    let viewFactory: ViewFactory
    @EnvironmentObject var languageManager: LanguageManager
    
    init(user: User, viewFactory: ViewFactory) {
        self.user = user
        self.viewFactory = viewFactory
    }
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Image(user.profileImageUrl ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                Spacer()
                HStack(spacing: 8){
                    UserStatView(value: 10, title: "profile.posts".localized)
                    UserStatView(value: 20, title: "profile.followers".localized)
                    UserStatView(value: 30, title: "profile.following".localized)
                }
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4){
                Text(user.fullname ?? "")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Text(user.bio ?? "")
                    .font(.footnote)
                Text(user.username)
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Button{
                if user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    // Follow
                }
            }label: {
                Text(user.isCurrentUser ? "profile.edit".localized : "profile.follow".localized)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(user.isCurrentUser ? Color(.white) : Color(.blue))
                    .cornerRadius(6)
                    .foregroundColor(user.isCurrentUser ? Color("buttonTextColor") : Color(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1)
                    )
            }
            .padding(.horizontal)
            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile) { 
            viewFactory.makeEditProfileView(user: user)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let viewFactory = PreviewHelpers.makeViewFactory()
        ProfileHeaderView(user: User.MOCK_USERS[0], viewFactory: viewFactory)
    }
}
