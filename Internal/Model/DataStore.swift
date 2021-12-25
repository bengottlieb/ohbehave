//
//  DataStore.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite
import Cirrus
import CoreData
import Journalist

public class DataStore: ObservableObject {
	public static let instance = DataStore()
	
	var configuration = Cirrus.Configuration(identifier: "iCloud.com.standalone.ohbehave", zones: ["patients"])

	public var viewContext: NSManagedObjectContext { SyncedContainer.instance.viewContext }
	
	public func setup() {
		let modelURL = Bundle(for: DataStore.self).url(forResource: "OhBehave", withExtension: "momd")
		let model = NSManagedObjectModel(contentsOf: modelURL!)
		SyncedContainer.setup(name: "OhBehave", managedObjectModel: model)
		let context = SyncedContainer.instance.importContext
		configuration.idField = "uuid"
		configuration.synchronizer = SimpleObjectSynchronizer(context: context)
		configuration.entities = [
			SimpleManagedObject(recordType: "patient", entityName: "Patient", in: context),
			SimpleManagedObject(recordType: "behavior", entityName: "Behavior", in: context),
			SimpleManagedObject(recordType: "day", entityName: "Day", parent: "patient", in: context),
		]
		Logger.instance.level = .verbose
		Task { await configure() }
	}
	
	var lastSyncedPredicate: NSPredicate {
		if let date = Settings.instance.lastSyncedBehaviorsAt {
			return NSPredicate(format: "modificationDate > %@", date as NSDate)
		}
		return NSPredicate(value: true)
	}
	
	public func configure() async {
		await Cirrus.configure(with: configuration)
		//try? await Cirrus.instance.container.publicCloudDatabase.deleteAll(from: ["behavior"])
		await Cirrus.instance.container.privateCloudDatabase.setupSubscriptions([.init()])

		await report {
			let date = Date()
			try await SyncedContainer.instance.sync(all: BehaviorMO.self, predicate: self.lastSyncedPredicate, in: .public)
			Settings.instance.lastSyncedBehaviorsAt = date
		}
	}
}
