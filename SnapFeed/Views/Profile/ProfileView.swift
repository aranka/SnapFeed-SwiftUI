import SwiftUI

struct ProfileView: View {
    
    let user: User
    let viewFactory: ViewFactory
    @EnvironmentObject var languageManager: LanguageManager
    
    init(user: User, viewFactory: ViewFactory) {
        self.user = user
        self.viewFactory = viewFactory
    }
    
    var posts: [Post] {
        return Post.MOCK_POST.filter { post in
            post.user?.username == user.username
        }
    }
    
    var body: some View {
        ScrollView {
            VStack{
                ProfileHeaderView(user: user, viewFactory: viewFactory)
                PostGridView(posts: posts)
                    .padding()
                
                Spacer()
            }
        }
        .navigationTitle("navigation.profile".localized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewFactory = PreviewHelpers.makeViewFactory()
        ProfileView(user: User.MOCK_USERS[0], viewFactory: viewFactory)
    }
}

