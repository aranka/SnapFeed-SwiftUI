import SwiftUI

struct FeedView: View {
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack{
                    ForEach(Post.MOCK_POST){ post in
                        FeedCard(post: post)
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("navigation.feeds".localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 28)
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                        .foregroundStyle(Color("buttonTextColor"))
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
