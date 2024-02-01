//
//  SceneDelegate.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//
import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
        
    private let coordinator: Coordinator<MapRouter> = .init(startingRoute: .loginView)
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        coordinator.setWindow(window: UIWindow(windowScene: windowScene))
        coordinator.start()
    }
}
