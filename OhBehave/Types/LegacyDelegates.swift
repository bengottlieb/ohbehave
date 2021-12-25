//
//  LegacyDelegates.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/25/21.
//

import SwiftUI
import CloudKit
import Internal
import Achtung
import Cirrus

@main
class LegacyAppDelegate: UIResponder, UIApplicationDelegate {
//	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//
//		let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
//		sceneConfig.delegateClass = SceneDelegate.self
//		return sceneConfig
//	}
	
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		
		let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
		sceneConfig.delegateClass = SceneDelegate.self
		return sceneConfig

//		 return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		DataStore.instance.setup()
		Achtung.instance.setup()
		return true
	}
	
//	func application(_ application: UIApplication, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {
//		print("Shared via app delegate")
//	}

}

class SceneDelegate: NSObject, UISceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else { return }

		let rootView = ContentScreen()
		  .environment(\.managedObjectContext, DataStore.instance.viewContext)


		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = UIHostingController(rootView: rootView)
		self.window = window
		window.makeKeyAndVisible()
		
		if let shareInfo = connectionOptions.cloudKitShareMetadata {
			Task {
				try? await Task.sleep(nanoseconds: 1_000)
				try? await Cirrus.instance.accept(share: shareInfo)
			}
		}
	}
	
	func sceneWillResignActive(_ scene: UIScene) {
		print("Good bye")
	}

	func windowScene(_ windowScene: UIWindowScene, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {

		print("Shared via scene delegate")
	}
}

/*
 <key>UIApplicationSceneManifest</key>
 <dict>
	 <key>UIApplicationSupportsMultipleScenes</key>
	 <false/>
	 <key>UISceneConfigurations</key>
	 <dict>
		 <key>UIWindowSceneSessionRoleApplication</key>
		 <array>
			 <dict>
				 <key>UISceneConfigurationName</key>
				 <string>Default Configuration</string>
				 <key>UISceneDelegateClassName</key>
				 <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
			 </dict>
		 </array>
	 </dict>
 </dict>

 */
