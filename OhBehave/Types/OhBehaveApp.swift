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

@main
struct OhBehaveApp: App {
	
	//@UIApplicationDelegateAdaptor(LegacyAppDelegate.self) var appDelegate
	
	init() {
		DataStore.instance.setup()
		Achtung.instance.setup()
		
		Task {
			report {
				let date = Date()
				await DataStore.instance.configure()
				try await SyncedContainer.instance.sync(all: BehaviorMO.self, predicate: OhBehaveApp.lastSyncedPredicate, in: .public)
				Settings.instance.lastSyncedBehaviorsAt = date
			}
		}
	}
	
	static var lastSyncedPredicate: NSPredicate {
		if let date = Settings.instance.lastSyncedBehaviorsAt {
			return NSPredicate(format: "modificationDate > %@", date as NSDate)
		}
		return NSPredicate(value: true)
	}
	
	var body: some Scene {
		WindowGroup {
			ContentScreen()
				.environment(\.managedObjectContext, DataStore.instance.viewContext)
		}
	}
}
