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

@main
struct OhBehaveApp: App {
	//@UIApplicationDelegateAdaptor(LegacyAppDelegate.self) var appDelegate
	
	init() {
		DataStore.instance.setup()
		
		Task {
			report {
				await DataStore.instance.configure()
				try await SyncedContainer.instance.sync(all: BehaviorMO.self, in: .public)
			}
		}
	}
	
	var body: some Scene {
		WindowGroup {
			ContentScreen()
				.environment(\.managedObjectContext, DataStore.instance.viewContext)
		}
	}
}
