import SwiftUI

struct FeedCard: View {
    
    let post: Post
    
    var body: some View {
        VStack{
            HStack{
                Image(post.user?.profileImageUrl ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text(post.user?.username ?? "")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.leading, 8)
            
            Image(post.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
                
            HStack{
                Button{
                    
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                }
                
                Button{
                    
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                
                Button{
                    
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 8)
            .foregroundStyle(Color("buttonTextColor"))
            
            Text("\(post.likes) likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)
                .padding(.top, 1)
            
            HStack(){
                Text(post.user?.fullname ?? "") + Text(", ") + Text(post.caption)
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.footnote)
            .fontWeight(.semibold)
            .padding(.leading, 8)
            .padding(.top, 1)
            Text("10h ago")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .fontWeight(.semibold)
                .padding(.leading, 8)
                .padding(.top, 1)
            
            Spacer()
            
            
        }
    }
}

struct FeedCard_Previews: PreviewProvider {
    static var previews: some View {
        FeedCard(post: Post.MOCK_POST[0])
    }
}
