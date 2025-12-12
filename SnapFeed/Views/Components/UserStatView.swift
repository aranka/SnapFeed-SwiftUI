import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack{
            Text("\(value)")
                .font(.footnote)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)
                .fontWeight(.semibold)
        }.frame(width: 76)
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(value: 10, title: "Posts")
    }
}
