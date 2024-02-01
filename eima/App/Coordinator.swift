//
//  Coordinator.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import SwiftUI

open class Coordinator<Router: NavigationRouter>: ObservableObject {
    
    public var navigationController: UINavigationController
    public var window: UIWindow?
    public let startingRoute: Router?
    
    public init(startingRoute: Router? = nil, navigationController: UINavigationController = .init(), window: UIWindow? = nil) {
        self.window = window
        self.startingRoute = startingRoute
        self.navigationController = navigationController
    }
    
    public func setWindow(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        guard let route = startingRoute else { return }
        show(route)
    }
    
    public func show(_ route: Router, animated: Bool = true) {

        let view = route.view()
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        switch route.transition {
        case .push:
            self.navigationController.pushViewController(viewController, animated: animated)
        case .change:
            guard let window = self.window else { return }
            self.navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        default:
            break
        }
    }
    
    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }

}
