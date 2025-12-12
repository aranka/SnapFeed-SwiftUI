import SwiftUI

struct PostGridView: View {
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    var posts: [Post]
    
    var imageDimension: CGFloat {
        return (UIScreen.main.bounds.width / 3) - 1
    }
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 1){
            ForEach(posts) { item in
                Image(item.imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
                    
            }
        }
    }
}

struct PostGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostGridView(posts: Post.MOCK_POST)
    }
}
