import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    @ObservedObject var viewModel: SearchViewModel
    let viewFactory: ViewFactory
    @EnvironmentObject var languageManager: LanguageManager
    
    init(viewModel: SearchViewModel, viewFactory: ViewFactory) {
        self.viewModel = viewModel
        self.viewFactory = viewFactory
    }
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack(spacing: 10){
                    ForEach(viewModel.users){ user in
                        NavigationLink(value: user) {
                            HStack{
                                Image(user.profileImageUrl ?? "")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                VStack(alignment: .leading){
                                    Text(user.username)
                                        .fontWeight(.semibold)
                                    Text(user.fullname ?? "")
                                }
                                .font(.footnote)
                                .foregroundStyle(Color("buttonTextColor"))
                                Spacer() 
                            }
                            .padding(.leading)
                        }
                        .navigationDestination(
                            for: User.self, 
                            destination: { user in
                                viewFactory.makeProfileView(user: user)
                            }
                        )
                    }
                }
                .searchable(text: $searchText, prompt: "search.placeholder".localized)
            }
            .navigationTitle("navigation.explore".localized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let viewFactory = PreviewHelpers.makeViewFactory()
        let viewModelFactory = PreviewHelpers.makeViewModelFactory()
        SearchView(viewModel: viewModelFactory.makeSearchViewModel(), viewFactory: viewFactory)
    }
}
