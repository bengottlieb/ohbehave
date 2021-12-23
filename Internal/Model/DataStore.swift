//
//  DataStore.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite
import Cirrus
import CoreData

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
	}
	
	public func configure() async {
		await Cirrus.configure(with: configuration)
	//	await try! Cirrus.instance.container.publicCloudDatabase.deleteAll(from: ["behavior"])
		await Cirrus.instance.container.privateCloudDatabase.setupSubscriptions([.init()])
	}
}
