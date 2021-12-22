//
//  Behavior.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import CoreData
import Cirrus


public class BehaviorMO: SyncedManagedObject {
	@NSManaged public var uuid: String
	@NSManaged public var title: String
	@NSManaged public var points: Int32
}
