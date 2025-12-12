import SwiftUI

struct MainTabView: View {
    
    @State private var selectedIndex = 0
    
    // MARK: - Dependencies (injected via ViewFactory)
    let viewFactory: ViewFactory
    let user: User
    
    init(user: User, viewFactory: ViewFactory) {
        self.user = user
        self.viewFactory = viewFactory
    }
    
    var body: some View {
        TabView(selection: $selectedIndex){
            viewFactory.makeFeedView()
                .onAppear(){
                    selectedIndex = 0
                }
                .tabItem { 
                    Image(systemName: "house.fill")
                }.tag(0)
            viewFactory.makeSearchView()
                .onAppear(){
                    selectedIndex = 1
                }
                .tabItem { 
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            viewFactory.makeUploadPostView(tabIndex: $selectedIndex)
                .onAppear(){
                    selectedIndex = 2
                }
                .tabItem { 
                    Image(systemName: "plus.square")
                }.tag(2)
            Text("Notifications")
                .onAppear(){
                    selectedIndex = 3
                }
                .tabItem { 
                    Image(systemName: "heart.fill")
                }.tag(3)
            viewFactory.makeMyProfileView(user: user)
                .onAppear(){
                    selectedIndex = 4
                }
                .tabItem { 
                    Image(systemName: "person")
                }.tag(4)
        }
        .accentColor(Color("tabBarItemColor"))
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        let viewFactory = PreviewHelpers.makeViewFactory()
        MainTabView(user: User.MOCK_USERS[0], viewFactory: viewFactory)
    }
}
