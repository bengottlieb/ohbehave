//
//  Behavior.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import CoreData
import Cirrus
import CloudKit
import Suite


public class BehaviorMO: SyncedManagedObject {
	@NSManaged public var uuid: String
	@NSManaged public var stringID: String
	@NSManaged public var title: String
	@NSManaged public var pointsValue: Int32
	@NSManaged public var kindsString: String?
	@NSManaged public var timesString: String?
	@NSManaged public var desc: String?
	@NSManaged public var unitString: String?
	@NSManaged public var earnedIfCompletedAtString: String?
	@NSManaged public var earnedUnlessLost: Bool

	override public var database: CKDatabase { .public }
	
	public override func awakeFromInsert() {
		super.awakeFromInsert()
		stringID = uuid
	}
}

extension BehaviorMO {
	public static func importDefaults(into context: NSManagedObjectContext) {
		for behavior in BehaviorInfo.defaultBehaviors {
			if context.behavior(with: behavior.id) != nil { continue }
			
			let new: BehaviorMO = context.insertObject()
			new.load(from: behavior)
		}
		context.saveContext()
	}

	func load(from behavior: BehaviorInfo) {
		stringID = behavior.id
		title = behavior.title
		timesString = behavior.times.joined(separator: ",")
		kindsString = behavior.kinds.joined(separator: ",")
		pointsValue = Int32(behavior.value)
		unitString = behavior.unit
		desc = behavior.description
		earnedIfCompletedAtString = behavior.earnedIfCompletedAt.stringValue
		earnedUnlessLost = behavior.earnedUnlessLost ?? false
	}
}
