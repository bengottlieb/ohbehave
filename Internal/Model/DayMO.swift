//
//  Day.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite
import Cirrus
import CloudKit
import Journalist
import CoreData

public class DayMO: SyncedManagedObject {
	@NSManaged public var uuid: String
	@NSManaged public var title: String
	@NSManaged public var date: Date
	@NSManaged public var behaviorData: Data?
	@NSManaged public var patient: PatientMO?
	
	var _loggedBehaviors: [LoggedBehavior]?

	override public var database: CKDatabase { .private }
	
	public var dayTitle: String {
		date.formatted(as: "dd MMM")
	}
	
	public func totalEarned(for reward: BehaviorMO.RewardUnit) -> Int {
		guard let ctx = self.managedObjectContext else { return 0 }
		let all = loggedBehaviors.compactMap { $0.behavior(in: ctx) }
		let matching = all.filter { $0.rewardUnit == reward }
		let points = matching.map { $0.pointsValue }
		return Int(points.sum())
	}
	
	public var isToday: Bool { date.isToday }
	
	override public func awakeFromInsert() {
		super.awakeFromInsert()
		self.date = Date()
	}
}
