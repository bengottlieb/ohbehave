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
	@NSManaged public var earnedMultipleTimes: Bool

	open override var defaultDatabase: CKDatabase { .public }

	public override func awakeFromInsert() {
		super.awakeFromInsert()
		stringID = uuid
	}
	
	public var earnedIfCompletedAt: Date.Time? {
		try? Date.Time.load(fromString: earnedIfCompletedAtString ?? "")
	}
}

extension BehaviorMO {
	public static func importDefaults(into context: NSManagedObjectContext) {
		for behavior in BehaviorInfo.defaultBehaviors {
			if let existing = context.behavior(with: behavior.id) {
				existing.load(from: behavior)
			} else {
				let new: BehaviorMO = context.insertObject()
				new.load(from: behavior)
			}
		}
		context.saveContext()
	}
	
	public var canBeLost: Bool {
		guard let before = earnedIfCompletedAt else { return false }
		
		return before < Date().time
	}

	func load(from behavior: BehaviorInfo) {
		if self.behaviorInfo == behavior { return }
		
		stringID = behavior.id
		title = behavior.title
		timesString = behavior.times.joined(separator: ",")
		kindsString = behavior.kinds.joined(separator: ",")
		pointsValue = Int32(behavior.value)
		unitString = behavior.unit
		desc = behavior.description
		earnedIfCompletedAtString = behavior.earnedIfCompletedAt.stringValue
		earnedUnlessLost = behavior.earnedUnlessLost ?? false
		earnedMultipleTimes = behavior.earnedMultipleTimes ?? false
	}
	
	var behaviorInfo: BehaviorInfo {
		BehaviorInfo(kinds: kindsString?.commaSeparated ?? [], times: timesString?.commaSeparated ?? [], title: title, description: desc, value: Int(pointsValue), unit: unitString ?? "", earnedIfCompletedAt: earnedIfCompletedAt, earnedUnlessLost: earnedUnlessLost, earnedMultipleTimes: earnedMultipleTimes)
	}
}

fileprivate extension String {
	var commaSeparated: [String] {
		let results = components(separatedBy: ",")
		if results == [""] { return [] }
		return results
	}
}
