import SwiftUI

struct MyProfileView: View {
    
    let user: User
    let authService: any AuthServiceProtocol
    
    var posts: [Post] {
        return Post.MOCK_POST.filter { post in
            post.user?.username == user.username
        }
    }
    
    // MARK: - Dependencies (injected)
    let viewFactory: ViewFactory
    @EnvironmentObject var languageManager: LanguageManager
    
    init(user: User, authService: any AuthServiceProtocol, viewFactory: ViewFactory) {
        self.user = user
        self.authService = authService
        self.viewFactory = viewFactory
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    ProfileHeaderView(user: user, viewFactory: viewFactory)
                    
                    PostGridView(posts: posts).padding()
                    
                    Spacer()
                }
            }
            .navigationTitle("navigation.my.profile".localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        authService.signOut()
                    }label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(Color("buttonTextColor"))
                    }
                }
            }
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewFactory = PreviewHelpers.makeViewFactory()
        viewFactory.makeMyProfileView(user: User.MOCK_USERS[0])
    }
}
