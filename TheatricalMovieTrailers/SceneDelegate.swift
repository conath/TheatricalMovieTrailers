//
//  SceneDelegate.swift
//  TheatricalMovieTrailers
//
//  Created by Chris on 26.06.20.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let viewParameters = ViewParameters()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let view = ContentView()
        let dataStore = MovieInfoDataStore.shared
        let contentView = view.environmentObject(dataStore).environmentObject(viewParameters)
        
        // Was the scene opened from a URL call (e. g. widget)
        if let urlContext = connectionOptions.urlContexts.first, urlContext.url.absoluteString.hasPrefix(MovieInfoDataStore.urlScheme) {
            let url = urlContext.url.absoluteString
            guard let id = Int(url.suffix(from: url.firstIndex(of: "=")!).dropFirst()) else {
                assertionFailure("Malformed id URL parameter: expected integer")
                return
            }
            /// App needs a bit to catch up
            DispatchQueue.main.asyncAfter(0.5) { [self] in
                viewParameters.showTrailerID = Int(id)
            }
        }

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let windowSceneObject = WindowSceneObject(windowScene)
            let contentView = contentView.environmentObject(windowSceneObject)
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts urlContexts: Set<UIOpenURLContext>) {
        // Was the scene opened from a URL call (e. g. widget)
        if let urlContext = urlContexts.first, urlContext.url.absoluteString.hasPrefix(MovieInfoDataStore.urlScheme) {
            let url = urlContext.url.absoluteString
            guard let id = Int(url.suffix(from: url.firstIndex(of: "=")!).dropFirst()) else {
                assertionFailure("Malformed id URL parameter: expected integer")
                return
            }
            /// App needs a bit to catch up
            DispatchQueue.main.async { [self] in
                viewParameters.showTrailerID = id
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    

}

