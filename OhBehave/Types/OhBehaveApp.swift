//
//  OhBehaveApp.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite
import Internal
import Cirrus
import Journalist
import SwiftUI
import Achtung

//@main
struct OhBehaveApp: App {
	
	//@UIApplicationDelegateAdaptor(LegacyAppDelegate.self) var appDelegate

	
	init() {
		DataStore.instance.setup()
		Achtung.instance.setup()
	}
	
	var body: some Scene {
		WindowGroup {
			ContentScreen()
				.environment(\.managedObjectContext, DataStore.instance.viewContext)
		}
	}
}
