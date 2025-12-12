import Foundation
import SwiftUI

/// Base protocol for all coordinators
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    
    func start()
    func finish()
}

extension Coordinator {
    /// Add a child coordinator
    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    /// Remove a child coordinator
    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
    
    /// Finish coordinator and remove from parent
    func finish() {
        childCoordinators.removeAll()
    }
}

/// Coordinator for managing navigation in SwiftUI
protocol SwiftUICoordinator: ObservableObject {
    associatedtype Route: Hashable
    var path: NavigationPath { get set }
    
    func navigate(to route: Route)
    func pop()
    func popToRoot()
}

extension SwiftUICoordinator {
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

