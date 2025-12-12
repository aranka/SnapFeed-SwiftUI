import Foundation
import FirebaseAuth
import Combine

class ContentViewModel: ContentViewModelProtocol {
    
    // MARK: - Dependencies
    private let authService: any AuthServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Published Properties
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    // MARK: - Initialization
    init(authService: any AuthServiceProtocol) {
        self.authService = authService
        setupSubscribers() 
    }
    
    
    func setupSubscribers() {
        authService.userSessionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userSession in
                self?.userSession = userSession
            }
            .store(in: &cancellables)
        
        authService.currentUserPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.currentUser = user
            }
            .store(in: &cancellables)
    }
    
}
