//
//  OhBehaveApp.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite
import Internal

@main
struct OhBehaveApp: App {
	//@UIApplicationDelegateAdaptor(LegacyAppDelegate.self) var appDelegate
	
	init() {
		DataStore.instance.setup()
	}
	
	var body: some Scene {
		WindowGroup {
			ContentScreen()
				.environment(\.managedObjectContext, DataStore.instance.viewContext)
		}
	}
}
