import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    @ObservedObject var registerViewModel: RegisterViewModel
    
    // MARK: - Dependencies (injected)
    let viewFactory: ViewFactory
    
    init(
        viewModel: ContentViewModel, 
        registerViewModel: RegisterViewModel, 
        viewFactory: ViewFactory
    ) {
        self.viewModel = viewModel
        self.registerViewModel = registerViewModel
        self.viewFactory = viewFactory
    }
    
    var body: some View {
        Group{
            if viewModel.userSession == nil {
                viewFactory.makeLoginView(registerViewModel: registerViewModel)
            } else if let currentUser = viewModel.currentUser {
                viewFactory.makeMainTabView(user: currentUser)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewFactory = PreviewHelpers.makeViewFactory()
        let viewModelFactory = PreviewHelpers.makeViewModelFactory()
        ContentView(
            viewModel: viewModelFactory.makeContentViewModel(),
            registerViewModel: viewModelFactory.makeRegisterViewModel(),
            viewFactory: viewFactory
        )
    }
}
