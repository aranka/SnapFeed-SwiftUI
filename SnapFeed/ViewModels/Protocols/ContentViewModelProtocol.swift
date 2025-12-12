import Foundation
import FirebaseAuth
import Combine

/// Protocol for ContentViewModel
protocol ContentViewModelProtocol: ObservableObject {
    var userSession: FirebaseAuth.User? { get }
    var currentUser: User? { get }
}

