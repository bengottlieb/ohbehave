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
	
	var configuration = Cirrus.Configuration(identifier: "iCloud.com.standalone.ohbehave", zones: ["kids"])

	public func setup() async {
		let modelURL = Bundle(for: DataStore.self).url(forResource: "OhBehave", withExtension: "momd")
		let model = NSManagedObjectModel(contentsOf: modelURL!)
		SyncedContainer.setup(name: "OhBehave", managedObjectModel: model)
		let context = SyncedContainer.instance.importContext
		configuration.idField = "uuid"
		configuration.synchronizer = SimpleObjectSynchronizer(context: context)
		configuration.entities = [
			SimpleManagedObject(recordType: "child", entityName: "Child", in: context),
			SimpleManagedObject(recordType: "behavior", entityName: "Behavior", in: context),
			SimpleManagedObject(recordType: "day", entityName: "Day", parent: "child", in: context),
		]
		
		await Cirrus.configure(with: configuration)
		Logger.instance.level = .verbose
		await Cirrus.instance.container.privateCloudDatabase.setupSubscriptions([.init()])

	}
}
