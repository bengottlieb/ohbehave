//
//  Day.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite
import Cirrus
import CloudKit

public class DayMO: SyncedManagedObject {
	@NSManaged public var uuid: String
	@NSManaged public var title: String
	@NSManaged public var date: Date
	@NSManaged public var patient: PatientMO?

	override public var database: CKDatabase { .private }
	
	public var dayTitle: String {
		date.formatted(as: "dd MMM")
	}
	
	public var isToday: Bool { date.isToday }
	
	override public func awakeFromInsert() {
		super.awakeFromInsert()
		self.date = Date()
	}
}
