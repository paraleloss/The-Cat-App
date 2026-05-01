//
//  SceneDelegate.swift
//  The-Cat-App
//
//  Created by Saúl Pérez on 30/04/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Asegúrate de que scene es de tipo UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Crear la ventana
        window = UIWindow(windowScene: windowScene)
        
        // Crear el controlador raíz (BreedSelectionViewController dentro de un NavigationController)
        let breedSelectionVC = BreedSelectionViewController()
        let navigationController = UINavigationController(rootViewController: breedSelectionVC)
        
        // Asignar el controlador raíz a la ventana
        window?.rootViewController = navigationController
        
        // Hacer visible la ventana
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
    }
}
